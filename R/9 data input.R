######################################################
################# 데이터 입출력 #####################

####################################################

# 키보드로부터 데이터를 받을 수 있음

# 1.scan()
  # 1) scan() 함수를이용해서숫자데이터를 받을 수 있다
  
    myNum <- scan()
  #아래 콘솔창에 데이터를 입력하면 됨
    myNum

  # 2) scan()을 이용해서문자열도 입력받을수 있다
    var1 = scan(what=character())
    
    var1


# 2.edit()
  # 키보드로부터 데이터를 받기 위해서 
  #  edit() 함수를 이용할 수 있다

    var1 <- data.frame() # 빈 데이터 프레임을 만들고 거기에 edit로 입력
    df= edit(var1)
    df

    
###################################################
    
# 파일로부터 데이터를 읽어올 수 있음
# text 파일에 ","로 구분된 데이터들을 읽어오기
    
# read.table()을 사용
getwd()
    
#잠시 워킹디렉토리를 data폴더로 변경할것
# C:/R_Lecture   /data
setwd("C:/r_lecture/data/")
setwd(str_c(getwd(),"/data"))
getwd()    

# 방법1  # 파일명과 확장자로 불러오기
student_midterm = read.table(file="student_midterm.txt",
                             sep=",",
                             fileEncoding="UTF-8")
                    # 한글인코딩이 있는경우 유니코드 지정
# 방법2   # 파일 열기 창 사용
student_midterm = read.table(file.choose(),
                             sep=",",
                             fileEncoding="UTF-8")

# 방법 3   #헤더(열이름)이 있는 경우
student_midterm = read.table(file.choose(),
                             sep=",",
                             fileEncoding="UTF-8",
                             header=T) 
                            
student_midterm


########################################################



#### 실행 내용지우기#####

var1 =c("홍길동")  #scalar
var2 = c(10,20,30)

#1) environment 창
rm(list=ls()) #ls(): 환경창에 있는객체를 얻을수 있음
# 따라서 환경창 객체 리스트를 지우라는 의미

#2) console창 지우기
cat("\014")



########################################################
#### 자주 사용되는 데이터 포멧 #########

# 파일로 부터 데이터를 읽어들일 때
# 일반 txt 형식은 많이 사용되지 않는다

# 컴퓨터간에 데이터를 주고 받으려고 한다

# process 간에 데이터 통신을 하기 위해서
# 특정 형식을 이용해 데이터를 주고 받는데
# 이 때 일반적으로 많이 이용하는 3가지 형태가 있다.

# 1. csv ( comma seperated value )
    # comma기호를 이용해서 데이터를 구분
    # 해당 문자열을 전달해서 데이터 통신
    # 예) "홍길동, 20, 서울, 김깅동, 30, 부산, 최길동,
    #     50,인천,....."
  
  # 1) CSV 방식장점 
    # 구조가 간단함, redundant한 데이터가 적음,
    # 상대적으로 크기가 작음
    # => 많은양의 데이터를 처리할 수 이음

  # 2) CSV 방식 단점
    # 구조적 데이터를 표현하기에 적합하지 않다
    #  ==> parsing 작업이 복잡함 
    #(프로그램에서 사용할 수 있는 형태로 바꿔주는 작업)
    # = 유지 보수의 문제. 부가비용이 많이 발생
  
  # 데이터 사이언스에서는 사용 데이터용량이 너무 
    # 커서 어쩔 수 없이 CSV 데이터를 사용하는 경우가
    # 많다

# 2. XML 방식  (2000년대 유행)
    # tag를 이용해서 데이터를 표현하는 방식
    # 예) <name> 홍길동 </name><age>20</age>
    #     <address>서울</adress>...
    # tag의 중첩이 가능함
    # 예)  <phone>
    #         <mobile>010-111-1111</mobile>
    #        <home> 02-342-2233</home>
    #     </phone>
  
    # 1) XML 방식 장점
      # - 구조표현이 용이함
      # - 사용하기 편리(유지보수 용이)
      # - 데이터의 의미를표현할 수 있음
  
    # 2) XML 방식의 단점
      # - redundant한 자료가 차지하는 용량이 너무 큼

# 3.JSON ( JavaScript Object Notation )
#  자바스크립트 객체 표현법
#   예) {name : "홍길동", age: 20, adress:서울,...}
# 구조적 표현이 가능하면서 XML보다크기가작다




############# CSV 불러오기 #####################
# read.table() : sep이 있어야함 (구분자명시)
# read.csv() : sep default가 ,임 (구분자 생략가능)
#             header= T 가 기본
getwd()

df = read.csv(file.choose(),
              fileEncoding="UTF-8")
df


############# Excel 파일을 불러오기 ###########
# 확장 package를 이용해야 한다

# R을 설치하면 .. => base system이 설치된다고 표현한다
# base package, recommended package
# 둘다 설치가 되어있으나, recommended package는
# 로드를 해야 쓸 수 있음
# other package는 설치와 로드를 모두해야

# xlsx package를 설치하고 로딩하자

install.packages("xlsx")
library(xlsx)

# java home 환경변수 설정(why????)
  # JDK에대한Java home 폴더 경로를 잡아줘야함 
  # 폴더표현시 역슬래시 2개를 써야함에 유의
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jdk1.8.0_231")

student_midterm <-read.xlsx(file.choose(),
                           sheetIndex = 1,
                           encoding = "UTF-8")
student_midterm 

######################################################

# 처리된 결과를 file에 write하기
# 3가지 함수를 알아 둘 것

# write.table(): data frame을 파일에 저장
# cat () : 분석결과(vector)를 파일에 저장
# captur.output():분석결과(list, table)을 file에 저장

cat("처리된 결과는 :","\n","\n", #\n줄바꿈
    file="C:/R_Lecture/data/report.txt",
    append=T); #동일명의 자료가 이미 있으면, 자료안에 추가

write.table(student_midterm, 
            file="C:/R_Lecture/data/report.txt",
            row.names = F, #행번호 삭제
            quote = F, #문자열의 ""삭제
            append = T);

capture.output(summary(student_midterm),
               file="C:/R_Lecture/data/report.txt",
               append = T);
               
# write xlsx()
df = data.frame(X=c(1:5),
                y=seq(1,10,2),
                x=c("a","b","c","d","e"),
                stringsAsFactors =F);
          # 범주형X 캐릭터로 사용
df


write.xlsx(df, file="C:/R_Lecture/data/report.xlsx")

# JASON 처리는 이후 웹을 배운 뒤에 할 예정














