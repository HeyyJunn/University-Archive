# class -> type
# class 로부터 object 생성
# oop class

# list type 을 갖는 instance
# .append 란 method 사용

# abstract data type
# object & operation (data handling)

# decomposition 나누기
# abstraction 감추기

# abstract data types

class IntSet(object):
    # constructor
    def __init__(self):
        self.vals = []

    def insert(self, e):
        if not e in self.vals:
            self.vals.append(e)

    def member(self, e):
        return e in self.vals

    def remove(self, e):
        try:
            self.vals.remove(e)
        except:
            raise ValueError(str(e) + ' not found ')

    def __str__(self):
        self.vals.sort()
        result=' '
        for e in self.vals:
            result += str(e) + ','
        return '{' + result[:-1] + '}'

# print(s) s의type은 intset
# intset type 을 print 할 것을 __str__ 에서 정의
# 먼저 해당되는 list sort -> result 을 string 으로 변환 후 처음부터 끝까지 (마지막 comma 제외) 출력






# 파이썬은 파이썬을 개선하기 위한 개선 제안서인 PEP 8의 표준 코드 작성 스타일 가이드가 있다. PEP 8에서는 이름 표기인 네이밍 컨벤션에 대해 다음과 같이 명시한다.
#
# - 모듈 이름은 소문자로 작성한다.
#
# - 변수 및 함수명 : 스네이크케이스(snake_case)
#
# - 클래스명 : 카멜케이스(camelCase)
#
# - 인스턴스 메소드(method)의 첫 인자는 언제나 self
#
# - 클래스 메소드의 첫 인자는 언제나 cls다.
#
# - 변수명에서 언더바(_)는 위치에 따라 다음 의미를 가진다.
# [출처] [Python] 파이썬 PEP 8 이름 표기와 카멜, 스네이크 케이스|작성자 넬티아