# 과제6 60241996 김민준
count = input("학생의 수를 입력하세요: ")
divisors = []
sum_score = 0
maxVal, minVal = None, None

for i in range(int(count)):
    divisors.append(int(input("성적을 입력하세요: ")))
    sum_score += divisors[i]

    if maxVal is None or divisors[i] > maxVal:
        maxVal = divisors[i]
    if minVal is None or divisors[i] < minVal:
        minVal = divisors[i]

print("성적 평균은 " + str(sum_score/len(divisors)) + " 입니다")
print("가장 높은 점수는 " + str(maxVal) + " 입니다.")
print("가장 낮은 점수는 " + str(minVal) + " 입니다.")

