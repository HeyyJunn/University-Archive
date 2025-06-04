data("sleep")
str(sleep)
head(sleep)


# 두 개의 수면제는 다른 효과를 나타내는가?
sleep
sleep2=sleep[,-3]
sleep2
tapply(sleep2$extra, sleep2$group, mean)

var.test(extra ~ group, sleep2) #H0: Accepted. Same Variance
t.test(extra ~ group, data = sleep2, var.equal = TRUE)

# 개인별로 볼 때 서로 다른 약물의 수면 시간 증가폭은 다르다고 할 수 있는가?
# 
# 두 개의 그룹이 나눠졌을 때 서로 ㅗ간계가 없다는 가정하에 1번 그룹, 2번 그룹의 평균을 구하여
# 비교
# 가만 보면 1번 약을 먹었을 때 0.7 - 1.9 만큼 수면 시간의 증가
# 2: -1.6 - 0.8 만큼의 차이가 있는 것. 
# 3: 1번 약을 먹으면 -0.2 - 1.1 의 차이
# 이렇게 해서 10명의 데이터.
# 각각의 차이값이 총 10개. -> 10개 나온 데이터의 평균, 그 평균이 0이어야 ..
# 같은 사람끼리의 pair 를 이루어서 그것의 차이의 합이 0 인지를 확인해야함.

with(sleep, t.test(extra[group==1], extra[group==2], paired=TRUE))
# 대립가설: 차이가 0이 아니다 ( 즉 차이가 있다 ) 를 채택함
# 0을 포함하지 않음
# 여러번 반복하여 모집단을 추정하면 해당 범위에 있고, 해당 범위는 0을 포함하지 않음



prop.test(42,  100)
# 이항으로 안하고 정규분포로 하고자 함
# 앞면 뒷면 할 것 없이 p = 42, n  = 100)
# p 값이 0.1336
# 0.5가 아니길 기대하였지만 0.42 는 우연히 나온거고, 실제 앞면이 나올 확률은 95프로 확신한건데 0.32 와 0.52 사이에 있어.
# 앞면이 나올 비율이 50프로가 맞다

prop.test(c(45,55), c(100,90))
# 항상 이런건지 검정을 해보자
# 비율 -> 비율 검정, 이표본
# 정규분포로 근사될 수 있으니 prop.test
# 앞이 성공이 될 확률의 개수, 뒤는 전체
# 두 확률의 차이를 봤더니 음수값


prop.test(c(16,63), c(430,1053))
# 2-sample test for equality of proportions with continuity
# correction
# 
# data:  c(16, 63) out of c(430, 1053)
# X-squared = 2.6653, df = 1, p-value = 0.1026
# alternative hypothesis: two.sided
# 95 percent confidence interval:
#   -0.04717571  0.00193619
# sample estimates:
#   prop 1     prop 2 
# 0.03720930 0.05982906 


# 0.05 의 오차가 누적됨
# 다수의 집단을 한번에 분석하고자 함 -> ANOVA
# 겹친다 -> 평균이 거의 같다 세개의 집단의 평균의 분산 ( 평균이 떨어진 정도가 작다) 이 작다



# 그룹별 데이터 정의
xx <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
yy <- c(1.09, 2.12, 2.92, 4.06, 4.90, 6.08, 7.01, 7.92, 8.94)
zz <- c(1.10, 1.96, 2.98, 4.09, 4.92, 6.10, 6.88, 7.97, 9.01)
# 데이터 결합
mydata <- c(xx, yy, zz)  # 벡터로 결합
# 그룹 지정 (1, 2, 3 그룹 각각 9개씩)
group <- c(rep(1, 9), rep(2, 9), rep(3, 9))
# Oneway ANOVA 실행 (등분산 가정 O → var = TRUE)
oneway.test(mydata ~ group, var = TRUE)
# F = 6.526e-06, num df = 2, denom df = 24, p-value = 1










