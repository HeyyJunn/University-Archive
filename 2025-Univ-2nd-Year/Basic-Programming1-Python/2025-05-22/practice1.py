def getAverage(vect):
    avg = 0
    for elem in vect:
        try:
            avg += float(elem)
        except:
            raise ValueError("Cannot calculate invaild arguments.")
    try:
        avg /= len(vect)
    except ZeroDivisionError:
        return float("nan")
    return avg


try:
    myList = [100, 20, 43, 57, 12, 66, 77]
    # myList = [10,20,30,40,50,"sss"]
    print(f"Input: {myList}")
    avg = getAverage(myList)
    print(f"Average result is {avg}")
except ValueError as errorMsg:
    print(errorMsg)
