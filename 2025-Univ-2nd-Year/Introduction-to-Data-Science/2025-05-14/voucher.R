data = read.csv("schoolVoucher.csv")
data$Voucher

data_table = table(data$Voucher)
data_table


chisq.test(data_table, p = c(1/3, 1/3, 1/3))

#0.0000003.63 만큼 일어날 확률 카이 쉐엉 ㅔ해당되는 20.6은
# 완전히 예외적인 경우미르 ㅗ대립가설을 선택한다. 귀무가설 기각 
# 선호도가 있다


## 동질성 검정
# 각 범주에 대해서 같은 반으을 보이는지

# 8가지
# 각 1/8 확률일시 직업과 관련이 없게 됨
# 그 중 어느 것 하나라도 1/8이 유의미 하게 넘어ㄱ간다
# 직업ㅂ별 ㅇ 

# 귀무가설 1/8 = 1/8 = 1/8 = 1/8
# 자유도 행 열 고려
alcholic = c(32, 51 , 67, 83)
normal = c(268,199, 233, 267)
df = data.frame(alcholic, normal)
row.names(df) = c ("사무원", "교육자", "기업인", "상인")
chisq.test(df)
#  p-value = 0.0001277


