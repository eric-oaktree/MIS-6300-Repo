
class Obj():
    def __init__(self, v):
        self.test = 1
        self.total = v
    def add_1(self):
        b = self.total
        self.total = self.total + 1
        print(("You had "+str(b)+", Now you have "+str(self.total)))
    def fun_ction(self):
        return "So much Fun!"


o = Obj(-10)
x = 0
print(o.fun_ction())
while o.total <= 9:
    o.add_1()
    x = x + 1
print(o.fun_ction())
