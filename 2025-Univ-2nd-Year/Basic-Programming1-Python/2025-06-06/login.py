class LoggedError(Exception):
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return repr(self.value)


class Member(object):
    nextId = 0

    def __init__(self):
        self.id = Member.nextId
        Member.nextId += 1

    def getId(self):
        return self.id


class Customer(Member):
    def __init__(self, email, password):
        Member.__init__(self)
        self.email = email
        self.password = password
        self.loggedin = False

    def __str__(self):
        return self.email

    def signin(self, email, password):

        if self.loggedin:
            raise LoggedError("Already signed in.")
        if self.email != email or password != password:
            return False
        else:
            self.loggedin = True
            return True

    def signout(self):
        if not self.loggedin: # 로그아웃이 되어있다면.
            raise LoggedError("Already signed out.")
        self.loggedin = False


# TEST CODE
c1 = Customer("abc@abc.com", "12341234")
c2 = Customer("def@def.com", "56785678")
c3 = Customer("hello@world.com", "qwerty")

print("Customer 1 is {}".format(c1))
print("Customer 2 is {}".format(c2))
print("Customer 3 is {}".format(c3))

print("Customer 1's id is {}".format(c1.getId()))
print("Customer 2's id is {}".format(c2.getId()))
print("Customer 3's id is {}".format(c3.getId()))

try:
    print("Customer 1 sign-in {}".format(c1.signin("abc@abc.com", "12341234")))
except LoggedError as e:
    print(e)

try:
    print("Customer 2 sign-out {}".format(c2.signout()))
except LoggedError as e:
    print(e)

try:
    print("Customer 3 sign-in {}".format(c3.signin("abc@abc.com", "12341234")))
except LoggedError as e:
    print(e)