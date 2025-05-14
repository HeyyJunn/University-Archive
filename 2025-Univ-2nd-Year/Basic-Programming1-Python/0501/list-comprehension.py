L1 = [x ** 2 for x in range(1,7)]
print(L1)


L2 = [1, 2, 'a', 3, 4.0]
print([x** 2 for x in L2 if type(x) == int])
# 반드시 좋은 방법이라 할 수 없음
# 가독성이 낮음

