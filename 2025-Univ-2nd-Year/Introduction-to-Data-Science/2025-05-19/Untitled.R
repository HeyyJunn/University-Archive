library(MASS)
str(survey)
# 명목형 변수에 대한 검정 통계
# 1. 일단 교차 테이블을 생성한다.
SexExer = xtabs(~Sex+Exer, data=survey)
SexExer
# 0.05 보다 큰 값이므로, 귀무
chisq.test(SexExer)



HndClap = xtabs(~W.Hnd + Clap, data = survey)
HndClap
chisq.test(HndClap)
# p-value = 6.598e-05 , 0.000006~ 0.05 보다 작으므로 대립가설을 택한다. 
# 독립적이지 않다는 것, 둘 사이에 관계가 있다.
fisher.test(HndClap)
# approximation 이 정확치 않다고 나오면 fisher.test
# fisher 의 test 답이 조금 다르게 나옴
# 그렇지만 똑같은 대립가설을 택해야 하는 상황



# W.Hnd 와 Fold 의 관계
HndFold = xtabs(~W.Hnd + Fold, data = survey)
HndFold
chisq.test(HndFold) # p-value = 0.4535
fisher.test(HndFold) # p-value = 0.4782
# W.Hnd 와 Fold 는 관게가 없다

# Exercise 와 Smoke
ExerSmoke = xtabs (~Exer+Smoke, data = survey)
ExerSmoke
chisq.test(ExerSmoke)
fisher.teset(ExerSmoke)
# p-value 0.05 보다 크므로 귀무가설을 기각하지 않음
# 흡연 습관과 운동 수준은 관계가 없다 ( 독립적이다 )


# 관심있는 변수에 대한 교차 테이블을 만들고
# 교차테이블을 그대로 chisq.test 에 넣어준 뒤로 p 값만 확인하였음
# 독립성에 관련된 부분


##################################################



# 적합도 검정
# 귀무가설은 완두콩의 모양과 색깔의 2대 유전은 9:3:3:1 로 나타난다
# 완두콩의 모양과 색깔은 " 가 아니다.
x = c(315, 101, 108, 32)
chisq.test(x, p=c(9/16, 3/16, 3/16, 1/16))
# p-value = 0.9254 로 각각의 발현 비율이 9:3:3:1 이라는 
# 메델의 유전법칙을 따른다는 귀무가설을 기각할 수 없음



##################################################

data = read.csv("snsbyage.csv")
str(data)
# 귀무가설: 연령대별로 sns 이용률에는 차이가 없다.
# 대립가설: 
data$age = as.factor(data$age) 
data$service = as.factor(data$service)
data_table = xtabs(~age+service, data=data)
chisq.test(data_table)
# p-value = 0.05731 

# 2시 5분경
# service.c 우너래 가지고 있는 servicd data 를 순서를 FTKCE
# 2.2e-16 대립가설을 택해야한다

# data<-transform(data,service.c=factor(service,levels=c("F","T","K","C","E"),ordered=True))



# 독립성 검정 사례: 성별에 따른 대학원 입학 여부
# H0: 성별에 따른 합격자수는 차이가 없다
# H1: 성별에 따른 합격자수는 차이가 있다.
data(UCBAdmissions)
str(UCBAdmissions)
UCBAdmissions.df = as.data.frame(UCBAdmissions)

ucb_table = xtabs(Freq~Gender+Admit, data=UCBAdmissions.df)
mosaic(ucb_table,
       gp = gpar(fill=c("Red", "Blue"))
       
ucb_table2 = prop.table(ucb_table)
ucb_table2


# 성별에 따른 대학원 합격자수가 차이가 있다






# fisher test
# 각 칸 의 기대도수가 5보다 작은 칸이 많은 경우에는 fishers'extact test 수행
# 표본 수가 적거나 분할표가 치우치게 분포된 경우에 적용

child1 = c(5,11,1)
child2 = c(4,7,3)
Toy = cbind(child1, child2)
rownames(Toy) = c ("car", "truck", "doll")
Toy 
chisq.test(Toy)
fisher.test(Toy)




# KS 검정
x = norm(50)
y = runif(30)
ks.test(x,y)

# Shapiro Wilk 검정
# 정규분포 에 초점을 둠
# 샘플 사이즈가 크면 정규성을 띄게 되어있다, 30개 이상
# 데이터가 정규분포를 이루는지 점검하는 방법이
# Shapiro Wilk 검정
# w 는  변동률을 더한 것에 ~ㄱ 

# 샤프로 윌ㅋ크 검정은 분포가 정규분포인지를 검정하는 것이므로,
# 귀무가설: 정규 분포를 한다
# 대립가설: 정규 분포하지 않는다.

# p 값이 0.05 보다 크므로 귀무가설을 채택해서 정규분포를 한다고 본다.
shapiro.test(rnorm(100, mean = 5, sd= 3))
shapiro.test(runif(100, min=2, max=4))
# 두개의 집단이 다르다는 것을 표현하려면 정규분포 이어야 한다
# 모든 통계적 검정을 하기 전에 반드시 shapiro wilk 검정을 통해 정규성을 검




install.packages("UsingR")
library(UsingR)
str(cfb)
# customer 의 income 분포는 정규성을 보이는가?
# 정규성 검정
# 통계량에 의한 정규성 검ㅈ어: shapiro.test()
# 그래프에 의한 정규성 검정: histogram, QQ plot
shapiro.test(cfb$INCOME)
#  p-value < 2.2e-16 대립가설을 택해야한다, 정규분포가 아니다.

hist(cfb$INCOME, breaks = 100)
hist(cfb$INCOME, freq=FALSE, breaks= 100)
qqnorm(cfb$INCOME)
qqline(cfb$INCOME)
# 2시 33분 경부터 다시 듣기


