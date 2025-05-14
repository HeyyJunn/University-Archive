# 과제6 60241996 김민준
def listSort(list_x):
    for i in range(len(list_x), 0, -1):
        for j in range(0, i-1, 1):
            if list_x[j] > list_x[j+1]:
                temp = list_x[j]
                list_x[j] = list_x[j+1]
                list_x[j+1] = temp
    return list_x


def merge(list_x, tuple_x):
    result = list_x + list(tuple_x)
    listSort(result)
    return result


myTuple = (10, 20, 30, 40)
listSize = 5
myList = []

for i in range(listSize):
    myList.append(int(input("숫자를 입력해 주세요: ")))

listSort(myList)
newList = merge(myList, myTuple)
print("tuple과 list를 합친 결과 result ", newList)
print("내 list 정렬 값 ", myList)


