class Mpg:
    
    
    def __init__(self,ma,mo,d,y,cyl,t,drv,cty,hwy,fl,cl):
        self.mManu = ma
        self.mModel= mo
        self.mdispl= float(d)
        self.mYear = int(y)
        self.mCyl = float(cyl)
        self.mTrans = t
        self.mDrv = drv
        self.mCty = int(cty)
        self.mHwy = int(hwy)
        self.mFl = fl
        self.mClass = cl
        self.mEffic = self.cal_avgE()
        
        
    def cal_avgE(self):
        return (self.mCty + self.mHwy)/2 
    def print_mpg(self):
        print(self.mYear, self.mCty)
    def print_all(self):
        print("제조사:{}\t 모델명:{}\t 배기량:{}\t 제조년도:{}\t 차종:{}"
              .format(self.mManu, self.mModel, self.mdispl,self.mYear, self.mClass))   