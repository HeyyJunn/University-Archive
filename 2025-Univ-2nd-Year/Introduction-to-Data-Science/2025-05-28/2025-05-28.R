tire = read.csv("tire.csv")
str(tire)

tire$Brands = as.factor(tire$Brands)
str(tire)

library(dplyr)
library(ggplot2)
tire %>% group_by(Brands) %>%
  summarise(N=n(), Mean=mean(Mileage),
            Meidan = median(Mileage),
            Min = min(Mileage),
            Max=max(Mileage),
            Sd= sd(Mileage))
boxplot(tire$Mileage ~ tire$Brands,
        main = "Boxplot comparing Mileage of Four Brands of Tires",
        col = rainbow(4),
        horizontal = TRUE)

tires.aov = aov(Mileage ~ Brands, tire)
summary(tires.aov)
TukeyHSD(tires.aov, conf.level = 0.95)
# 차이에 대한 신뢰구간



##### 실습3 anova 감기약+ 피로도
drug = read.csv("drug.csv")
drug
drug$fatigue = ordered(drug$fatigue, levels = c("low", "med", "high"))
str(drug)
drug$fatique = ordered(drug$fatique, levels = c("low", "med", "high"))
boxplot(dose ~ fatigue, data = drug,
        xlab = "fatigue", ylab = "dose",
        col = c("blue", "red", "yellow"))



aov.model1 = aov(dose ~ fatigue, data = drug)
summary(aov.model1 )
par(mfrow = c(2,2))
plot(aov.model1)
# 등분산성 : 샘플링을 계속했을 때 분산이 동일해야한다


attatch(drug)
aov.model1 = aov(dose ~ fatigue, data = drug)
summary(aov.model1)

aov.model2 = update(aov.model1, subset(drug, patientID != 20 ))
summary(aov.model2)

# 20번째 환자를 제외하고 모델을 만들었더니 영향이 있따?


patient.gender = as.factor(c("F","F","F","M","M","F","M","M","M","M",
                             "F","F","F","M","M","M","F","F","F","M"))

aov.model3 = aov(dose ~ fatigue + gender, data = drug)
summary(aov.model3)
# 성별 요인을 모형에 추가


anova ( aov.model1, aov.model3)
# 대개의 경우 anova3 을 쓴다?
# 두 모형이 서로 크게 다르지 안흥면
# 데이ㅓ를 설명하는 보다 간단한 모형을 선택


diet = read.csv("diet.csv")
str(diet)
diet$gender = as.factor(diet$gender)
diet$Diet = as.factor(diet$Diet)
diet$weightloss = diet$pre.weight - diet$weight6weeks
# 성별에 따라서 weight lossa 가 다른가?
# 다이어트 방법에 따라서 " ?
# 이 성별에 이 다이어트 방법에 따라서 " ?
diet %>%
  group_by(gender) %>%
  summarise(mean_weightloss = mean(weightloss))
diet %>%
  group_by(Diet) %>%
  summarise(mean_weightloss = mean(weightloss))
diet %>%
  group_by(gender, Diet) %>%
  summarise(mean_weightloss = mean(weightloss))
diet_aov = aov(weightloss ~ as.factor(gender) * as.factor(Diet), data = diet)
summary(diet_aov)
# 모든 경우를 다 한꺼번에 해주는 표시가 곱하기 *
# 2개 factor 은 +
# 상호작용 6가지 ->
# 1,2,3번 약품 효과 가 다름
# 성별 다이터 상호작용에 의한 효과는 있음.
# plot ( diet_aov) ??
# normality 
res = diet_aov$residuals
hist(res, main = "jancha histogram")
TukeyHSD(diet_aov)

# 3 = 1  차이가 있다
# 3 - 1 = 1.8 몸무게 줄얻느ㅡㄴ 효과가 3번 다이어트가 더 좋다
# 3 3-2 차이가 0이 포함되어 있지 않음 오후 2:26 기준 녹음본
# 2개의 요인을 가지고 anova 분석시 
# 각각이 독립적으로 차이가 있는가?
# 상호자굥으로 인한 모든 경우에 대한 부분을 다 보고
# tillda 를 기준으로 독립변수 사이의 곱하기로만 하게 되면 상호작용까지 보여줌

# 1. 분석한 .r 코드
# 2.  data csv.이다? csv 그대로 주고 rdataset 이면 기재하면 됨
# 3. 분석 report 의 pdf
# 이러이러한 데이ㅓ였다 아노바 분석하기 전의 기술통계, 그래프 시각화한 부분,
# 아노바 분석을 ㅐㅎㅆ더니 결과가 이랬다.
# 결국 이건 차이가 있다 ㅇ벗다 conclusion
# 그것을 report 에 삽입









#########################################################

# t 명목변수에 따른 
# 집단 기준에 따라서 3개 이상이면 anova
# 상관분석에 있을 때는 둘다 평균이 있어야함
# 둘다 연속변수 연속변수 일 때
# 
# 상관관계가 어떻다의 통계치 -> 상관계수
# 상관계수 값은 -1 부터 1까지의 값을 취함
# 0의 값을 취한다는 것은 두 변수가 서로 독립이다. 아무 앗ㅇ관관계가 업삳
# 
# 상관계수 분석방ㅇ법
# 1, 피어슨 !!!!!!!!!!!1 연속형
# 2, 스피어만
# 3, 켄달 순위!!!!!!!!!!!!11연속이 아니라 순서형 데이터 1,23456789 순서대로 되어있을 때 그때도 상관계굿를 구할 수 있도록
# 
# 주로 피어슨이 default 가 됨

# E 평균이 얼마인가? 기대값.
# 공분산 /  y 분산 곱
# cor 상관계쑤를 구한다
# corrgram 그래프 : 
# iris data Sepal.

# 상관관계가 ~ 모집단에 대해서 정확히 추론?
# 둘 사이에 어떠한 방정식으로 나탄ㄹ 수 잇는가?
# ->회귀분석으로 이루어짐
#

