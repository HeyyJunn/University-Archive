#reopen with encoding: CP949

str(ds.total)
unique(ds.total$수집연월)                 # 수집연월
unique(ds.total$상권업종대분류명)         # 상권업종 대분류
unique(ds.total$상권업종중분류명)         # 상권업종 중분류
unique(ds.total$상권업종소분류명)         # 상권업종 소분류

# NA 포함여부 확인
sum(is.na(ds.total))

# 201712 수집 데이터만 추출


# 업종별 점포수(대분류)

store.level_1
names(store.level_1)[2] = c("count")


#library(dplyr)
#store.level_1_1 = ds.201712%>% group_by(상권업종대분류명)%>%
#                  summarise(count=n())
#store.level_1_1

ggplot(store.level_1, aes(x=reorder(대분류, -count), y=count)) +
  geom_bar(stat="identity", width=0.7, fill="steelblue") +
  ggtitle("업종별 점포수") +
  theme(plot.title = element_text(color="black", size=14, face="bold"),
  axis.text.x = element_text(size=7, angle = 45))

# 
#구별 점포수 
#


store.region
names(store.region)[2] = c("count")

ggplot(store.region, aes(x=구이름, y=count)) +
  geom_bar(stat="identity", width=0.7, fill="steelblue") +
  ggtitle("구별 점포수") +
  theme(plot.title = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(size = 6, angle = 45))

#구별 점포수를 지도로 나타내기
store.region.loc <- aggregate(ds.201712[,c("경도","위도")], 
                              by=list(구이름=ds.201712$시군구명),
                              FUN=mean)

register_google(key="AIzaSyAujsxaJv5VaRimIM5cf9bGrUGMGS5TGjI")


map <- get_googlemap(center=cen,                # 마커 없는 지도 가져오기
                     maptype="roadmap",
                     size=c(640,640),
                     zoom=11)
gmap <- ggmap(map)                              # 지도를 저장

gmap+geom_point( ,                        
                 ,
                alpha=0.5, col="red") +
  scale_size_continuous(range = c(1, 15))+      # 원의 크기 조절
  geom_text(data=store.region,                  # 지도위에 텍스트 표시
            aes(x=경도,y=위도),                 # 텍스트 위치 (= 구의 좌표) 
            size=3,                             # 텍스트 크기
            label=store.region$구이름)          # 텍스트 내용


#점포수가 많은 상위 10개동을 알아내고 막대그래프로 나타내시오


store.dong
names(store.dong)[2] = c("count")


dong.top10 <- store.dong[1:10,]
dong.top10

ggplot(dong.top10, aes(x=reorder(동이름, -count), y=count)) +
  geom_bar(stat="identity", width=0.7, fill="steelblue") +
  ggtitle("점포수 많은 상위 10개동") +
  theme(plot.title = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(angle = 45))
