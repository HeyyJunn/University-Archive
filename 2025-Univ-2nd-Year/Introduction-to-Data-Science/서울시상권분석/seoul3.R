#업종별 점포수의 변화
#Q5: 수집연월일별(1:5) 업종별(대분류) 점포수의 변화를 분석하시오.



head(store.change)
names(store.change)[3] <- c("count")

ggplot(  ) + 
  geom_line() + 
  geom_point(size=6, shape=19, alpha=0.5) +
  ggtitle("업종별 점포수 변화 (대분류)") +
  ylab("점포수") + 
  scale_x_continuous(breaks=1:5, 
                     labels=files) +
  theme(plot.title = element_text(color="black", size=14, face="bold"))


#점포수 변화가 큰 상위 10개 업종
#Q6: 201512, 201712 두 기간에 점포수 변화가 큰 상위 10개 업종을을 알아내시오
#소분류체계 기준



names(store.tmp)[3] <- c("count")


names(store.201512)[3] <- c("cnt_2015")


names(store.201712)[3] <- c("cnt_2017")




top10


ggplot(store.change, aes(x=연월, y=count, colour=업종소분류, group=업종소분류)) +
  geom_line() + 
  geom_point(size=6, shape=19, alpha=0.5) +
  ggtitle("점포수 변화 Top 10 업종(소분류)") +
  ylab("점포수") + 
  scale_x_continuous(breaks=1:5, 
                     labels=files) +
  theme(plot.title = element_text(color="black", size=14, face="bold"))


#Q7: 5개년도 구별 점포수의 변화를 분석하시오



names(store.gu)[3] <- c("count")
ggplot(               ) +
  geom_line() + 
  geom_point(size=6, shape=20, alpha=0.5) +
  ggtitle("구별 점포수 변화 (대분류)") +
  ylab("점포수") + 
  scale_x_continuous(breaks=1:5, 
                     labels=files) +
  theme(plot.title = element_text(color="black", size=14, face="bold"))


#
# Q8: 201512,201712 두기간에 점포수 변화가 큰 상위 10개 행정동을 확인하시오
#
store.tmp <- 
  
names(store.tmp)[3] <- c("count")


names(store.dong.201512)[3] <- c("cnt_2015")

names(store.dong.201712)[3] <- c("cnt_2017")


top10


ggplot(               ) +
  geom_line() + 
  geom_point(size=6, shape=19, alpha=0.5) +
  ggtitle("점포수 변화 Top 10 동") +
  ylab("점포수") + 
  scale_x_continuous(breaks=1:5, 
                     labels=files) +
  theme(plot.title = element_text(color="black", size=14, face="bold"))

