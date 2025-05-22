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


# main


try:
    myList = [10,20,30,40,50,"sss"]
    # myList = [10,20,30,40,50,"sss"]
    print("Input: {}".format(myList))
    avg = getAverage(myList)
    print("Average result is {}".format(avg))
except ValueError as errorMsg:
    print(errorMsg)
