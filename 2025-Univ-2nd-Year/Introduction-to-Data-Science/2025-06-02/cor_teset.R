library(ggplot2)
economics = as.data.frame(economics)
cor.test(economics$unemploy, economics$pce)
# 0.6145176 
# 꽤 큰 양의 상관관계

# 95% 신뢰하는 구간에서 0.5608868 0.6630124 ?
ggplot() +
  geom_line(data = economics,
            aes(x = date, y = unemploy, color = "unemploy")) +
  geom_line(data = economics,
            aes(x = date, y = pce, color = "pce")) +
  labs(title = "Unemploy vs. PCE", x = "date", color = "Legend")


# correlationi matrix
head(mtcars) # 11개 속성 11 by 11 matrix 
car_cor = cor(mtcars) 
round(car_cor, 2)
library(corrplot)
corrplot(car_cor)

corrplot(car_cor, method="color",
         type="lower", order="hclust",
         addCoef.col = "black",
         tl.col = "black", tl.srt = 45, diag= F)

m = matrix(c(1:10, (1:10)^2), ncol=2)
cor(m, method = "spearman")
cor(m, method = "pearson")


data("airquality")
str(airquality)
head(airquality)

col1 = mapply(anyNA, airquality)
col1
# na 값 바꾸려면 그 값에 na 대신에 0을 줌
# 0 을 대입하게 되면 relation 이 깨지게 됨
# 해당 월의 추이를 그대로 유지하기 위해서 해당 month의 평균값을로 대체
# Compute monthly mean in Ozone
for (i in 1:nrow(airquality)){
  if(is.na(airquality[i, "Ozone"])){
    airquality[i, "Ozone"] <- mean(airquality[which(airquality[, "Month"] == airquality[i, "Month"]), "Ozone"], na.rm = TRUE)
  }
  # Compute monthly mean in Solar.R
  if(is.na(airquality[i, "Solar.R"])){
    airquality[i, "Solar.R"] <- mean(airquality[which(airquality[, "Month"] == airquality[i, "Month"]), "Solar.R"], na.rm = TRUE)
  }
}
head(airquality)
# na 가 있어서 해당 month 의 평균값으로
# 정규화
normalize <- function(x){
  return((x - min(x)) / (max(x) - min(x)))
}
airquality <- normalize(airquality)

library(corrplot)

airquality_cor <- cor(airquality)
corrplot(airquality_cor,
         method = "color",
         type = "lower",
         addCoef.col = "black")
# 상관관계 분석 -> 상관관계가 있다 없다 이지
#                 어떤게 원인이다 결과이다를 알려주진 못함

