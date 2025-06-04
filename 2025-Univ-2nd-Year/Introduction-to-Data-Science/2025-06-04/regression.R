data(cars)
full = lm (dist ~ speed, data = cars)
summary(m)

reg = read.csv("regression.csv", fileEncoding = "euc-kr")
# 상관관계가 크다 -> 회귀모델 생성
head(reg)
tail(reg)

plot(reg$weight, reg$height)
# 키와 몸무게 사이에 선형 관계가 있어 보임 
# 2) 
cor(reg$height, reg$weight) #  두 변수 사이에 상관관계가 매우 높음
# > cor(reg$height, reg$weight)
# [1] 0.9672103
r=lm(reg$height ~ reg$weight) # 선형회귀분석실시
abline(r) # 선형회귀식

summary(r)
# 20 정도 더 큰 값으로 책정된 값도 있고 13 정도 작게 예측된 값도 있고
# 대개의 경우에는 0 정도의 중앙값
plot(r)



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


Y = airquality[,"Ozone"]
X = airquality[,"Solar.R"]
model1 = lm(Y ~ X)
model1
plot(Y ~ X)
abline(model1, col = "blue", lwd = 3)

#