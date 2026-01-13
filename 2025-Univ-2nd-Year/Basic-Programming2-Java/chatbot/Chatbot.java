package chatbot;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.Button;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.geometry.Insets;
import javafx.geometry.Pos;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Chatbot extends Application {

    // 과제 슬라이드 예시 파일
    private static final String FILE_MID  = "middle.txt";
    private static final String FILE_HIGH = "high.txt";
    private static final String FILE_UNIV = "university.txt";

    private TextArea conversationArea = new TextArea();
    private TextField inputField = new TextField();

    private Button btnSend = new Button("Send");
    private Button btnMiddle = new Button("중학생");
    private Button btnHigh = new Button("고등학생");
    private Button btnUniv = new Button("대학생");

    private String currentFile = FILE_MID;

    private final ExecutorService executor = Executors.newSingleThreadExecutor();

    private ChatbotLlmClient llmClient; // 실제로는 RealLlmClient가 들어감(없으면 null)

    @Override
    public void start(Stage primaryStage) {

        // RealLlmClient는 기본 생성자가 없으니 여기서 직접 생성
        String apiKey = "blank"; // api 키
        if (apiKey != null && !apiKey.isBlank()) {
            String model = "solar-pro";
            double temperature = 0.7;
            int maxTokens = 256;
            llmClient = new ChatbotRealLlmClient(apiKey, model, temperature, maxTokens);
        } else { // gpt 예외처리
            llmClient = null; // 키 없으면 mock fallback
        }

        conversationArea.setEditable(false);
        conversationArea.setWrapText(true);

        HBox levelBox = new HBox(10, btnMiddle, btnHigh, btnUniv);
        levelBox.setPadding(new Insets(5));
        levelBox.setAlignment(Pos.CENTER_LEFT);

        inputField.setPromptText("Type your message...");
        HBox inputBox = new HBox(10, inputField, btnSend);
        inputBox.setPadding(new Insets(5));
        inputBox.setAlignment(Pos.CENTER);

        VBox bottomBox = new VBox(5, levelBox, inputBox);

        btnSend.setOnAction(e -> handleSend());
        inputField.setOnAction(e -> handleSend());

        btnMiddle.setOnAction(e -> switchMode(FILE_MID));
        btnHigh.setOnAction(e -> switchMode(FILE_HIGH));
        btnUniv.setOnAction(e -> switchMode(FILE_UNIV));

        BorderPane root = new BorderPane();
        root.setCenter(conversationArea);
        root.setBottom(bottomBox);

        Scene scene = new Scene(root, 500, 400);
        primaryStage.setTitle("Chatbot");
        primaryStage.setScene(scene);
        primaryStage.show();

        conversationArea.appendText("Bot: Hello! This is a chatbot UI.\n");
        conversationArea.appendText("Bot: Messages are handled asynchronously.\n");

        // 시작 시엔 로드 문구 안 찍고 조용히 로드
        loadOnly(currentFile, false);
    }

    private void handleSend() {
        String userText = inputField.getText().trim();
        if (userText.isEmpty()) return;

        conversationArea.appendText("User: " + userText + "\n");
        conversationArea.appendText("Bot: (thinking...)\n");

        inputField.clear();
        inputField.requestFocus();

        generateResponseAsync(userText);
    }

    private void generateResponseAsync(String userText) {
        executor.submit(() -> {
            try {
                String reply;

                if (llmClient != null) {
                    // 버튼에 맞는 "진짜 명령(system prompt)" 설정
                    String system = getSystemPromptByCurrentFile();

                    if (llmClient instanceof ChatbotRealLlmClient real) {
                        real.setSystemPrompt(system);
                    }

                    reply = llmClient.generate(userText);

                    if (reply == null || reply.isBlank()) {
                        reply = generateMockResponse(userText);
                    }
                } else {
                    reply = generateMockResponse(userText);
                }

                String finalReply = reply;
                Platform.runLater(() -> {
                    // (thinking...)
                    conversationArea.appendText("Bot: " + finalReply + "\n");
                });

            } catch (Exception e) {
                Platform.runLater(() -> conversationArea.appendText("Bot: Error occurred.\n"));
            }
        });
    }

    private String getSystemPromptByCurrentFile() {
        if (FILE_MID.equals(currentFile)) {
            return "너는 한국어 튜터야. 반드시 중학생 수준으로 아주 쉽게 설명해. 어려운 전문용어는 피하고, 짧은 문장으로 말해. 예시를 1개 들어줘.";
        } else if (FILE_HIGH.equals(currentFile)) {
            return "너는 한국어 튜터야. 고등학생 수준으로 명확하게 설명해. 필요한 용어는 써도 되지만, 짧게 정의를 덧붙여. 단계적으로 설명해.";
        } else {
            return "너는 한국어 튜터야. 대학생 수준으로 자세하고 논리적으로 설명해. 필요하면 개념/근거/예시를 포함해도 된다.";
        }
    }

    private String generateMockResponse(String message) {
        String lower = message.toLowerCase();
        if (lower.contains("hi") || lower.contains("hello")) return "Hello!";
        if (lower.contains("time")) return "It's always coding time!";
        if (lower.contains("bye")) return "Goodbye!";
        return "You said: " + message;
    }

    private void handleSave(String file) {
        try {
            Path path = Paths.get(file);
            Files.write(path, conversationArea.getText().getBytes(StandardCharsets.UTF_8));
            showInfo("Save Chat", "Chat saved to " + path.toAbsolutePath());
        } catch (IOException e) {
            showError("Save Error", e.getMessage());
        }
    }

    private void switchMode(String targetFile) {
        // 현재 대화 저장
        handleSave(currentFile);

        // 모드 변경 + 로드
        currentFile = targetFile;
        loadOnly(currentFile, true);
    }

    private void loadOnly(String file, boolean showLoadedMessage) {
        try {
            Path path = Paths.get(file);
            if (!Files.exists(path)) {
                Files.writeString(path, "", StandardCharsets.UTF_8);
                conversationArea.setText("");
                return;
            }

            conversationArea.setText(Files.readString(path, StandardCharsets.UTF_8));

            if (showLoadedMessage) {
                conversationArea.appendText("\nBot: Loaded previous chat history.\n");
            }
        } catch (IOException e) {
            showError("Load Error", e.getMessage());
        }
    }

    private void showError(String title, String message) {
        Alert alert = new Alert(AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    private void showInfo(String title, String message) {
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    @Override
    public void stop() {
        executor.shutdownNow();
    }

    public static void main(String[] args) {
        launch(args);
    }
}