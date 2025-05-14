# Q9: 역삼1동 상권분석: 대분류에 따라 상점의 위치를 지도에 나타냄
ds.yeoksam <- 
  
cen <- 
map <- get_googlemap(               # 마커 없는 지도 가져오기
                     maptype="roadmap",
                     size=c(640,640),
                     zoom=15)
gmap <- ggmap(map)                              # 지도를 저장
gmap+geom_point(                ) +
  labs(x = "Longitude", y = "Latitude",
       title="역삼1동 업종별 점포", color = "업종")


#Q10: 커피전문접/카페/다방 업종 분석
ds.yeoksam2 <- 
gmap+geom_point(                ) +
  labs(x = "Longitude", y = "Latitude",
       title="역삼1동 커피점" )

