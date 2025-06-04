def getAverage(vect):
    avg = 0
    for elem in vect:
        # assert type(elem) is (int or float), 'Cannot calculate invalid arguments.'
        assert isinstance(elem, (int, float)), 'Cannot calculate invalid arguments.'
        avg += elem
    try:
        avg /= len(vect)
    except ZeroDivisionError:
        return float("nan")
    return avg


try:
    myList = [100, 20, 43, 57, 12, 66, 77, 'aaa']
    # myList = [100, 20, 43, 57, 12, 66, 77]
    # myList = []
    print(f"Input: {myList}")
    avg = getAverage(myList)
    print(f"Average result is {avg:.2f}")
except AssertionError as errorMsg:
    print(errorMsg)


