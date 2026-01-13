package chatbot;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class ChatbotRealLlmClient implements ChatbotLlmClient {

    private final String apiKey;       // LLM 서비스 API 키
    private final String model;        // 사용할 모델 이름
    private final double temperature;  // 샘플링 온도
    private final int maxTokens;       // 최대 생성 토큰 수

    // 중/고/대학생 수준을 "진짜 system prompt"로 넣기 위해 가변으로 둠
    private String systemPrompt = "You are a helpful assistant.";

    public ChatbotRealLlmClient(String apiKey, String model, double temperature, int maxTokens) {
        this.apiKey = apiKey;
        this.model = model;
        this.temperature = temperature;
        this.maxTokens = maxTokens;
    }

    public void setSystemPrompt(String systemPrompt) {
        if (systemPrompt == null || systemPrompt.isBlank()) return;
        this.systemPrompt = systemPrompt;
    }

    @Override
    public String generate(String prompt) {
        if (prompt == null) prompt = "";

        try {
            URL url = new URL("https://api.upstage.ai/v1/solar/chat/completions");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + apiKey);

            String jsonBody = buildRequestJson(systemPrompt, prompt);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes("UTF-8"));
            }

            int code = conn.getResponseCode();
            InputStream is = (code >= 200 && code < 300) ? conn.getInputStream() : conn.getErrorStream();

            StringBuilder sb = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) sb.append(line);
            }

            return parseResponse(sb.toString());

        } catch (Exception e) {
            return "";
        }
    }

    private String buildRequestJson(String system, String userPrompt) {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"model\":\"").append(escapeJson(model)).append("\",");
        sb.append("\"messages\":[");
        sb.append("{\"role\":\"system\",\"content\":\"").append(escapeJson(system)).append("\"},");
        sb.append("{\"role\":\"user\",\"content\":\"").append(escapeJson(userPrompt)).append("\"}");
        sb.append("],");
        sb.append("\"temperature\":").append(temperature).append(",");
        sb.append("\"max_tokens\":").append(maxTokens);
        sb.append("}");
        return sb.toString();
    }

    // 간단 파싱: response JSON에서 첫 content 문자열만 뽑아옴
    private String parseResponse(String body) {
        if (body == null || body.isEmpty()) return "";

        String key = "\"content\":\"";
        int idx = body.indexOf(key);
        if (idx < 0) return "";

        int start = idx + key.length();
        StringBuilder sb = new StringBuilder();
        boolean escaping = false;

        for (int i = start; i < body.length(); i++) {
            char c = body.charAt(i);
            if (escaping) {
                if (c == '"' || c == '\\' || c == '/') sb.append(c);
                else if (c == 'n') sb.append('\n');
                else if (c == 't') sb.append('\t');
                else if (c == 'r') sb.append('\r');
                else sb.append(c);
                escaping = false;
            } else {
                if (c == '\\') escaping = true;
                else if (c == '"') break;
                else sb.append(c);
            }
        }
        return sb.toString().trim();
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            switch (c) {
                case '\\': sb.append("\\\\"); break;
                case '"':  sb.append("\\\""); break;
                case '\n': sb.append("\\n");  break;
                case '\r': sb.append("\\r");  break;
                case '\t': sb.append("\\t");  break;
                default:   sb.append(c);
            }
        }
        return sb.toString();
    }
}