# 분할표 작성 함수
table(c("a","b","a","d","e","d","a","c","b"))
# table에 의해 아래와 같이 분할표 출력됨
# a가 3번 나왔고, b가 2번 나왔다는 의미
# a b c d e 
# 3 2 1 2 1

# xtabs를 이용하여 분할표를 작성하는 예
CTable <- data.frame(x = c("3","7","9","10"),
                     y = c("A1","B2","A1","B2"),
                     num = c(4,6,2,9))
CTable

# 생성된 CTable의 데이터
#   x  y  num
# 1 3 A1   4
# 2 7 B2   6
# 3 9 A1   6
# 4 10 B2  9

# num을 기준으로 분할표 만들기 (x 기준)
xtabs(num~x, data=CTable)
# x
#  3  7  9 10 
#  4  6  6  9

# num을 기준으로 분할표 만들기 (y 기준)
xtabs(num~y, data=CTable)
# y
# A1 B2 
# 10 15


# xtabs로 분할표 생성
temp <- xtabs(num~x+y, data=CTable)
temp
# temp:
#     y
# x   A1 B2
#  3   4  0
#  7   0  6
#  9   6  0
# 10   0  9

# 행에 대한 합
margin.table(temp, 1)
# x
#  3  7  9 10 
#  4  6  6  9

# 열에 대한 합
margin.table(temp, 2)
# y
# A1 B2 
# 10 15

# 전체 데이터의 합
margin.table(temp)

# addmargins로 행과 열의 합까지 함께 보기
addmargins(temp, margin=1)
addmargins(temp, margin=2)
addmargins(temp)


library(MASS)

# contingency table : table(x, y)
Car_table_3 <- with(Cars93, table(Type, Cylinders))
Car_table_3

# Cylinders
# Type     3  4  5  6  8  rotary
# Compact  0 15  0  1  0       0
# Large    0  0  0  7  4       0
# Midsize  0  7  1 12  2       0
# Small    3 18  0  0  0       0
# Sporty   0  8  0  4  1       1
# Van      0  1  1  7  0       0

# contingency table : xtabs(~ x + y, data)
Car_table_4 <- xtabs(~ Type + Cylinders, data = Cars93)
Car_table_4

# add margins to the table
addmargins(car_table4)

