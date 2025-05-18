# int float -> scalar type
# str -> non-scalar type, structured type

# TUPLES (ordered sequence of elements)
# simple generalization of str
t1 = (1, 'two', 3)
t2 = (t1, 3.25)

print(t2)
print(t1 + t2)
print((t1 + t2)[3])
print((t1 + t2)[2:5])


def findDivisors (n1, n2):
    divisors = () # the empty tuple
    for i in range(1, min(n1,n2) + 1):
        if n1%i ==0 and n2%i ==0:
            divisors += (i,) # i 란 값을 뒤에 삽입
    return divisors

divisors = findDivisors(20,100)
print(divisors)
total = 0
for d in divisors:
    total += d
print(total)


def findExtremeDivisors (n1, n2):
    divisors = ()
    minVal, maxVal = None, None
    for i in range(1, min(n1,n2) + 1): # (1, 101)
        if n1%i ==0 and n2%i ==0:
            if minVal == None or i < minVal:
                minVal = i
            if maxVal == None or i > maxVal:
                maxVal = i
    return (minVal, maxVal)


minDivisor, maxDivisor = findExtremeDivisors(100,200)
print(minDivisor, maxDivisor)

# the range function returns anobject of type rang

