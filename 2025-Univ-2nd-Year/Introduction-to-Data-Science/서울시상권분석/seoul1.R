#reopen with encoding: CP949
getwd()


library(ggplot2)
library(ggmap)
library(readxl)

files <- c("201512","201606","201612","201706","201712")
columns <- c( "상가업소번호", "상호명", "상권업종대분류명", "상권업종중분류명", 
              "상권업종소분류명", "시군구명", "행정동명", "경도", "위도")     
ds.total <- NULL

#ds$수집연월
#1: 201512
#2: 201606
#3: 201612
#4: 201706
#5: 201712

for (i in 1:length(files)) {
  # files에 있는 5개의 파일을 순서대로 1개씩 읽기 위한 반복문
  filename <- paste("seoul_", files[i], ".xlsx", sep = "")
  cat("read ", filename, "...\n") # 읽을 파일 이름 출력
 
  ds <- read_excel(filename) # 엑셀 파일 읽기
  ds <- data.frame(ds) # 데이터프레임 으로 변환
  ds <- ds[, columns] # 분석에 필요한 변수만 추출 
  ds$수집연월 <- rep(i, nrow(ds)) # 데이터 수집 시점
  ds.total <- rbind(ds.total, ds) # 데이터 통합
}
dim(ds.total)
head(ds.total)
tail(ds.total)


# 데이터 구조 확인
str(ds.total)

# 수집연월의 유일값 확인
unique(ds.total$수집연월) 

# 상권업종 대분류 확인
unique(ds.total$상권업종대분류명)

# 상권업종 중분류 확인
unique(ds.total$상권업종중분류명)

# 상권업종 소분류 확인
unique(ds.total$상권업종소분류명)

##################################################
# NA 포함 여부 확인
sum(is.na(ds.total))  # NA 값 개수 확인

# 201712 수집 데이터만 추출
ds.201712 <- subset(ds.total, ds.total$수집연월 == 5)
dim(ds.201712)  # 결과: [1] 321436    10

# 업종별 점포수 (대분류 기준)
store.level_1 <- aggregate(ds.201712[,1],
                           by = list(대분류 = ds.201712$상권업종대분류명),
                           FUN = length)

# 열 이름 바꿔주기 (x → count)
names(store.level_1)[2] <- c("count")

# 막대그래프 그리기
library(ggplot2)
ggplot(store.level_1, aes(x = reorder(대분류, -count), y = count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  ggtitle("업종별 점포수") +
  theme_bw() +
  theme(axis.text.x = element_text(color = "black", size = 14, face = "bold"),
        axis.text.y = element_text(size = 7, angle = 45))

#########################

# 구별 점포 수 집계
store.region <- aggregate(ds.201712[, 1],
                          by = list(구이름 = ds.201712$시군구명),
                          FUN = length)

# 열 이름 변경 (x → count)
names(store.region)[2] <- c("count")

# 막대그래프 그리기
ggplot(store.region, aes(x = reorder(구이름, -count), y = count)) +
  geom_bar(stat = "identity", width = 0.7, fill = "steelblue") +
  ggtitle("구별 점포수") +
  theme(
    plot.title = element_text(color = "black", size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45)
  )

#########################

# 위도/경도 평균값으로 구별 위치 계산
store.region.loc <- aggregate(ds.201712[, c("경도", "위도")],
                              by = list(구이름 = ds.201712$시군구명),
                              FUN = mean)

# 점포 수와 결합
store.region <- data.frame(store.region.loc, store.region.loc[, 2:3])
store.region$count <- aggregate(ds.201712[, 1],
                                by = list(구이름 = ds.201712$시군구명),
                                FUN = length)$x

# 구글맵 API 키 등록 (자기 키로 바꿔야 함)
register_google(key = "AIzaSyAFw3210sFaygVU_4ktse1_k2dja8nU1kk")

# 지도 중앙 좌표 설정
cen <- c(mean(store.region$경도), mean(store.region$위도))

# 구글 지도 가져오기
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 11,
                     size = c(640, 640))

# 지도 시각화
gmap <- ggmap(map)

# 점 + 텍스트 추가
gmap +
  geom_point(data = store.region,
             aes(x = 경도, y = 위도, size = count),
             alpha = 0.5, col = "red") +
  scale_size_continuous(range = c(1, 15)) +
  geom_text(data = store.region,
            aes(x = 경도, y = 위도, label = 구이름),
            size = 3)

##################################################

# 점포수가 많은 상위 10개 동 확인
store.dong <- aggregate(ds.201712[,1],
                        by = list(동이름 = ds.201712$행정동명),
                        FUN = length)

store.dong

names(store.dong)[2] <- c("count")
store.dong <- store.dong[order(store.dong$count, decreasing = T), ]
dong.top10 <- store.dong[1:10, ]
dong.top10

ggplot(dong.top10, aes(x = reorder(동이름, -count), y = count)) +
  geom_bar(stat = "identity", width = 0.7, fill = "steelblue") +
  ggtitle("점포수 많은 상위 10개동") +
  theme(
    plot.title = element_text(color = "black", size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45)
  )

