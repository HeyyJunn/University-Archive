def generateDictionary(n):
    dic={}
    for i in range(n):
        key = input("프로그래밍 언어 이름: ")
        value = input("프로그래밍 언어 설명: ")
        dic[key] = value
    return dic


def printDictionary(*dicts):
    for dic in dicts:
        for key in dic:
            print(key+":"+dic[key])

def translateDictionary(dic):
    t_dic={}
    for key in dic:
        print("=영어사전 생성=")
        print("descriptions:", dic[key])
        t_key = input("Input the name of the language in English: ")
        t_value = input("Input the description of the language in English: ")
        t_dic[t_key] = t_value
    return t_dic


def serachDictionary(*dicts):
    while True:
        found_keys = []
        search = input("Enter a word for search: ")

        for dic in dicts:
            for key in dic:
                if search in dic[key]:
                    found_keys.append(key)

        if found_keys:
            print("Search result: ", found_keys)
        else:
            print("No match!! Break!")
            break


n = int(input("Input number of programming languages: "))
dic1 = generateDictionary(n)
dic2 = translateDictionary(dic1)
serachDictionary(dic1, dic2)