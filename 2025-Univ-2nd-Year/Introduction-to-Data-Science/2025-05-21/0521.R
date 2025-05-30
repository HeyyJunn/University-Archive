#t,test(x, y=NULL, alternative=c("two.sided","less","greater"), mu=0, paired=FALSE, 


# 샘플 데이터 입력
a = c(980, 1008, 968, 1032, 1012, 996, 1021, 1002, 996, 1017)

# 정규성 검정 (Shapiro-Wilk test)
shapiro.test(a)

# Shapiro-Wilk normality test
# 
# data:  a
# W = 0.9757, p-value = 0.9382
# 귀무가설 유지: 이 데이터는 정규성이 있다

t.test(a, mu=1000, alternative="two.sided")
# > t.test(a, mu=1000, alternative="two.sided")
# One Sample t-test
# data:  a
# t = 0.5269, df = 9, p-value = 0.611
# alternative hypothesis: true mean is not equal to 1000
# 95 percent confidence interval:
#   989.4613 1016.9387
# sample estimates:
#   mean of x 
# 1003.2 

# a 데이터를 가지고 본 결과, 그것이 보이는 t 분포상의 t 값이 0.52 란 것을 알았고, 자유도 9에 해당하는 t 분포란 것을 알았다.
# 그럴때 우리가 증명하고자 했었던 대립가설은 표본의 평균이 아니라 true 모집단의 평균이 1000 이 아니란 것을 대립가설로 증명하고 싶은 것
# 그것에 대한 지지도 여부의 p값이 0.611
# 모집단의 평균은 1000이다. 귀무가설을 유지한다.
# 10개의 mean 값을 구하면 1003.2. 그치만 이것은 표본에서 보인 평균
# 모집단 으로 추정을 한다면, 모집단의 평균은 989.4613 1016.9387 일 것이다. 95프로 신뢴구간 내에서.
# 표본을 우연히 잘못 뽑아서 평균이 1000에 가까웠던 것






# 데이터 입력
a <- c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 88, 42, 39)

# 정규성 검정
shapiro.test(a)

# (t-test는 아직 안 나왔지만) 예고된 검정: 평균이 55보다 "올랐는지"
# 나중에 쓸 t-test 형식 예상
# t.test(a, mu = 55, alternative = "greater")


# 성적 데이터
a = c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 88, 42, 39)

# t-test 수행: 평균이 55보다 **크다(greater)** 를 검정
t.test(a, mu = 55, alternative = "greater")
# 3학년 1반 전체 학생들에 대한 판단을 내려보겠다
# 학생의 성적이 올랐다고 할 수 있는가? 
# greater
# 56.88889
# 우리가 비록 해당되는 것이 56.8889 이지만 이 값은 우연히 나온것 
# 모집단으로 봤을 대는 42.19295. 향상의 정도는 큰 값이 아니다. 그래서 기각.

# 사전, 사후 혈압 데이터 입력
pre <- c(13.2, 8.2, 10.9, 14.3, 10.7, 6.6, 9.5, 10.8, 8.8, 13.3)
post <- c(14.0, 8.8, 11.2, 14.2, 11.8, 6.4, 9.8, 11.3, 9.3, 13.6)
# 사전 측정치
shapiro.test(pre)
# 사후 측정치
shapiro.test(post)
# 등분산 검정 (F-test)
var.test(pre, post)
# 독립 표본 t-test 수행
t.test(pre, post)

# 귀무가설: 차이가 없다
# 대립가설: 차이가 있다
# p-value 가 0.7165 보다 크므로 귀무 가설 채택. 차이가 없다.
# -1 이란 차이를 모집단으로 해석하여 0 이라 할 수 있는가?
# 실제적으로 두 집단의 차이는 -2.74 에서부터 1.92 사이에 있습니다.
# 이 사이에 0이란 값이 포함되어 있다.
# -1.~ 란 차이는 원래는 0인데 우연히 관찰된 값
# 


