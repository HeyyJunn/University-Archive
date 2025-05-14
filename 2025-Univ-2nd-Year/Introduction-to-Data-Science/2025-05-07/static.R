# ✅ 결론부터 말하면
# 
# ✔ plot(density(...))는 데이터 기반의 추정 곡선
# ✔ plot(x, dnorm(...))은 이론적인 수학 곡선 (정규분포 공식 그대로)
# → 즉 둘은 목적과 해석이 다릅니다.

# 난수 생성
rnorm(100, 0, 10)
# 평균 0, 표준편차 10인 정규 분포로부터 난수 100개를 생성

# 확률밀도 생성
plot(density(rnorm(100000, 0, 10)))   
# 많은 수의 난수를 만들고 밀도 그림을 그리면 데이터의 분포를 알 수 있음
# rnorm(100000, 0, 10) → 정규분포에서 난수 10만 개 생성
# density() → 그 난수의 확률밀도추정곡선을 그림
# plot() → 곡선을 시각화

pnorm(0)  
# 표준 정규분포(평균 0, 표준편차 1)에서 x ≤ 0일 확률
# 0: 누적 분포 함수 → 결과는 0.5 (정규분포의 평균에서 누적 확률은 0.5)
qnorm(0.5)  
# 누적확률이 0.5일 때 해당하는 x값은 얼마인가?
# 0.5: 분위수 함수 → 정규분포에서 누적확률이 0.5가 되는 값 = 평균

# 정규분포의 밀도함수를 직접 그리는 방법
x = seq(-40, 40, length=100000) # 축 정의: -40부터 40까지 10만 개의 값 생성 (촘촘한 수열)
y = dnorm(x, mean=0, sd=10) 
# dnorm()은 정규분포의 확률 밀도 함수(PDF)
# x에 있는 각 값들에 대해 해당 정규분포의 곡선 높이 계산 (y축)
# x가 -40일 때의 높이, -39.999일 때의 높이, …, 40일 때의 높이까지 10만 개 구함
plot(x, y, type="l")    # 선그래프로 그림

# 누적분포 함수와 분위수 함수 예시 (다시 한번)
pnorm(0)
qnorm(0.5)



##################################################


# 실습: 확률 밀도 함수 활용
# 12세 미만인 어린이가 보통 하루에 마시는 물의 양이 평균이 7.5이고 표준편차가 1.5인 정규분포를 따른다고 가정하자.

# (1) 어린이가 4리터 이하의 물을 마실 확률은 얼마인가?
x = seq(0, 16, length=100)
y = dnorm(x, mean=7.5, sd=1.5)
# x의 각 값에 대해, 평균 7.5, 표준편차 1.5인 
# 정규분포의 확률 밀도값 f(x)를 계산해서 y에 저장하는 것.
plot(x, y, type="l",
     xlab="Liters per day",
     ylab="Density",
     main="Liters of water drunken by school children < 12 years old")

# 4이하의 물을 마실 확률 : Lower tail
pnorm(4, mean=7.5, sd=1.5, lower.tail=TRUE)
# lower.tail = TRUE
# TRUE (기본값) → x 이하 (좌측 누적확률)
# FALSE → x 초과 (우측 누적확률)


#####

plot.new()
plot(x, y, type="l",
     xlab="Liters per day",
     ylab="Density")

# 8리터 이상 물을 마실 확률
lower = 8
upper = 15

# 8과 15 사이에 있는 x값 모으기
i = x >= lower & x < upper
polygon(c(lower, x[i], upper),    # x좌표들 (시작점, 중간들, 끝점)
        c(0, y[i], 0),            # y좌표들 (밑변 0, 곡선 위, 다시 밑변 0)
        col = "red")              # 색상 지정
# polygon()은 plot 위에 덧붙이는 “색칠 도형”을 그리는 함수
# plot()이 먼저 그려져 있어야 하고, polygon()은 그 위에 채워진 면적을 추가
abline(h=0, col="gray")
#  y=0 (x축 위치)에 회색 선을 하나 긋는 것


# 확률 계산
pb = round(pnorm(8, mean=7.5, sd=1.5, lower.tail=FALSE), 2)
pb
pb.results = paste("Cumulative probability of a child drinking > 8L/day", pb, sep=":")
title(pb.results)



##################################################

# Monte Carlo Simulation
# Monte Carlo 시뮬레이션은 많은 무작위 샘플을 뽑고, 
# 그 중 조건을 만족하는 비율을 계산하여 복잡한 확률이나 적분을 근사하는 방법입니다.
 

runs <- 100000
sims <- rnorm(runs, mean=1, sd=10)
mc.integral <- sum(sims >= 3 & sims <= 6)/runs
mc.integral



##################################################



# 실습: Monete Carlo Simulation

# **단위 원 (반지름 1인 원)**과 그것을 포함하는 정사각형을 생각합니다.
# •	원의 면적 = π
# •	사각형의 면적 = 2 × 2 = 4
# ▶ 원이 사각형에 차지하는 비율 = π / 4
# 
# ⇒ 원 안에 무작위 점이 들어갈 확률도 π/4가 됩니다.
# 
# ▶ 이걸 바탕으로 π ≈ (원 안에 들어간 점의 비율) × 4

# runif(n, min = a, max = b)
# → [a, b] 구간에서 균등하게 분포된 난수 n개를 생성

library(ggplot2)
# 1. [-1, 1] 구간에서 x, y 좌표 각각 10,000개 무작위 생성
x = runif(n = 10000, min = -1, max = 1)
y = runif(n = 10000, min = -1, max = 1)

# 2. x^2 + y^2 ≤ 1 인 점은 원 안에 있음 (원의 방정식)
in_circle = ifelse(x^2 + y^2 <= 1, 1, 0)

# 3. 원 안에 있는 점 개수 세기
points_in_circle = sum(in_circle)

# 4. 전체 중에서 원 안에 있는 비율 × 4 = π 추정
pie_est = (points_in_circle / length(x)) * 4

# 5. 결과 출력
pie_est

# 6. 시각화: 원 안/밖 점들을 색으로 나눠서 그리기
pie_data = data.frame(x, y, in_circle)
pie_data

ggplot(pie_data, aes(x = x, y = y, color = as.factor(in_circle))) +
  geom_point()



##################################################

# 앞 슬라이드 ( 단일 시뮬레이션 )
#   - 단순히 1회 실행 
#   - 파이 추정 1회
# 현재 슬라이드 ( 함수와 및 반복 )
#   - 함수로 정의해 재사용 가능
#   - 다양한 점 개수로 반복 실험
#   - 추정 정확도가 점의 개수에 따라 어떻게 달라지는지 확인

# π 추정 함수 정의
estimate_pi <- function(seed = 28, iterations = 1000){
  # 시드 고정 → 매번 같은 결과 재현 가능하게
  set.seed(seed)
  
  # [-1, 1] 범위에서 난수 생성
  x <- runif(n = iterations, min = -1, max = 1)
  y <- runif(n = iterations, min = -1, max = 1)
  
  # 점 (x, y)의 거리 계산: sqrt(x² + y²)
  sum_sq_xy <- sqrt(x^2 + y^2)
  
  # 원 안에 들어간 점 찾기 (반지름 1인 원)
  index_within_circle <- which(sum_sq_xy <= 1)
  points_within_circle <- length(index_within_circle)
  
  # 비율 × 4 → π 추정
  pi_est <- 4 * points_within_circle / iterations
  return(pi_est)
}

# 테스트: 10,000개의 점으로 추정
estimate_pi(seed = 28, iterations = 10000)

# 다양한 반복 횟수로 테스트 (정확도 비교)
no_of_iterations <- c(10, 100, 1000, 10000, 100000, 1000000)

# 각 반복횟수마다 π 추정값 계산
res <- sapply(no_of_iterations, function(n) estimate_pi(iterations = n))

# 결과 이름 붙이기 (몇 번 반복했는지)
names(res) <- no_of_iterations

# 결과 출력
res



##################################################



## function
estimate_pi <- function(seed = 28, iterations = 1000){
  # set seed for reproducibility
  set.seed(seed)
  
  # generate the (x, y) points
  x <- runif(n = iterations, min = -1, max = 1)
  y <- runif(n = iterations, min = -1, max = 1)
  
  # calculate distance from origin
  sum_sq_xy <- sqrt(x^2 + y^2)
  
  # see how many points are within circle
  index_within_circle <- which(sum_sq_xy <= 1)
  points_within_circle <- length(index_within_circle)
  
  # estimate pi
  pi_est <- 4 * points_within_circle / iterations
  return(pi_est)
}

# get estimated value of pi for 10,000 points
estimate_pi(seed = 28, iterations = 10000)

# Increased Number of Generated Points Will Improve Estimation
no_of_iterations <- c(10, 100, 1000, 10000, 100000, 1000000)
res <- sapply(no_of_iterations, function(n) estimate_pi(iterations = n))
names(res) <- no_of_iterations
res


#####


# 분포 적합을 위한 패키지 설치 및 로드
install.packages("propagate")
library("propagate")

# 시드 고정 및 데이터 생성 (평균 5인 정규분포 데이터 10,000개)
set.seed(275)
observations = rnorm(10000, 5)

distTested = fitDistr(observations)

distTested$stat


#####
employee = read.csv("employees_ex.csv")
hist(employee$incentive[employee$year == 2007], breaks = 50)
hist(employee$incentive[employee$year == 2008], breaks = 50)
hist(employee$incentive[employee$gender == "F"], breaks = 50)
hist(employee$incentive[employee$gender == "M"], breaks = 50)
hist(employee$incentive[employee$negotiated == FALSE], breaks = 50)
hist(employee$incentive[employee$negotiated == TRUE], breaks = 50)


