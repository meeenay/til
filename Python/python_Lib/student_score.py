## class 정의

class Student:
    # class variable
    
    
    # 생성자 
    # instance variable
    def __init__(self,n,k,e,m):
        self.sName = n
        self.sKor= int(k)
        self.sEng= int(e)
        self.sMat= int(m)
        self.sAvg= self.cal_avg()
        
    # method
    def cal_avg(self):
        return (self.sKor + self.sEng + self.sMat)/3
    def print_student(self):
        print("학생의 이름은: {}, 평균은: {:.2f}".format(self.sName, self.sAvg))
        
        