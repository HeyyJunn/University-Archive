# Homework 5
# Name: 김민준 60241996
# Time Spent: 0:50

int_list = []

def my_sum(int_list):
    temp = 0
    for num in int_list:
        temp += num
    return temp


def my_max(int_list):
    temp = int_list[0]
    for i in range(1, len(int_list)):
        if int_list[i] > temp:
            temp = int_list[i]
    return temp


def my_min(int_list):
    temp = int_list[0]
    for i in range(1, len(int_list)):
        if int_list[i] < temp:
            temp = int_list[i]
    return temp


def my_avg(input_list):
    return round(my_sum(input_list) / len(input_list), 2)


while True:
    try:
        input_num = int(input("양정수를 입력하세요: "))

        if int_list == [] and int(input_num) < 0:
            print("음수는 종료 시에만 입력 가능합니다.")
            exit()
        if int(input_num) >= 0:
            int_list.append(input_num)
        else:
            break
    except ValueError:
        print("다시 양의 정수를 입력하세요.")


print("최대값은 " + str(my_max(int_list)))
print("최소값은 " + str(my_min(int_list)))
print("합은 " + str(my_sum(int_list)))
print("평균은 " + str(my_avg(int_list)))










