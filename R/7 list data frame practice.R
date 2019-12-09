
# 같은 데이터 타입을 저장하는 자료구조

# vector(1차원), matrix(2차원), Array(3차원 이상)



# 다른 데이터 타입을 저장하는 자료구조

# List(1차원), data frame(2차원)



# 범주형 자료구조 => Factor

# 범주형 데이터를 저장하기 위한 자료구조

# 범주형 데이터란

# 예를 들어 방의 크기가 "대", "중", "소" => level

# vector를 이용해서 factor를 만듦



# 6명의 혈액형 데이터를 vector에 저장하고 factor로 변형

var1 = c("A", "AB", "O", "A", "B", "B"); var1

# factor로 변형하는 함수 : factor()

factor_var1 = factor(var1);

factor_var1



# level의 갯수를 알아보는 함수

nlevels(factor_var1)    # 4, level의 갯수



levels(factor_var1)     # 사용되는 level 출력



is.factor(factor_var1)  # factor여부 판단, TRUE



##################################################

# 남성과 여성의 성별데이터로 factor를 생성하고

# 빈도수 구하기



var1 = c("MAN", "WOMAN", "MAN", "MAN", "MAN", "WOMAN");

var1



factor_gender = factor(var1)

factor_gender



# 빈도수 구하기

table(factor_gender)

plot(factor_gender)



#################################################



# List

# 1차원 선형구조, 다른 데이터 타입이 들어올 수 있음

# 중첩 자료구조

# 지금가지 했던 여러 자료구조들을 생성해서 List에 저장하기

# 파이선의 dictionary와 같이 key와 value를 가지고 있는 구조

# dictionary와 차이점은, 순서개념이 있다는 것

# 따라서 값 출력에 [[]](key)와 [](value)형태로 사용


var_scalar = 100; var_scalar;   # scalar

var_vector = c(10,20,30);        # vector

var_vector;



var_matrix = matrix(c(1:12), 
                    
                    ncol=3,
                    
                    nrow=4,
                    
                    byrow = T);

var_matrix = matrix(ncol=3, nrow=4)

var_matrix;



# array 만들기 dim=c(행수,열수,차원수)

var_array = array(c(1:12),dim = c(2,2,3));

var_array;



var_df = data.frame(id=1:4,
                    
                    name=c("홍길동","김길동","최길동","이길동"),
                    
                    age=c(30,50,60,20));

var_df;



# list 만들기

myList = list(var_scalar,
              
              var_vector,
              
              var_matrix,
              
              var_array,
              
              var_df);

myList;

# 리스트의 인덱스 사용

myList[1];      # key와 value모두 출력

myList[2]

# 리스트의 키 사용

myList[[1]];    # key만 출력

myList[[2]]
class(myList[[3]]) #matrix


# key와 value로 저장되는 자료구조이고

# 데이터를 출력할 때 key값도 같이 출력

# [[n]] <- list의 key값



myVector = c(10,20,30);

myVector[2];


myList = list(name=c("홍길동", "김길동"), 
              age=c(20,30),
              adress=c("서울", "부산"))
myList # $name <-$는 키를 의미
        #[1] "홍길동" "김길동"

        #$age
        #[1] 20 30

        #$adress
        #[1] "서울" "부산"


myList$name  # List에서 kye를 사용할 때는 $ 기호를 이용
              # 가장일반적 ↑
              # 그외의 방법들로 아래와 같은 것들이 있다
myList[1]    # 1번방의 kye와 자료를 모두 보여줌
myList$name[2] # List에서 kye값과 벡터의 순서를 이용해 자료를 출력
myList[[1]]  # 이 형태도 가능
myList[["name"]]  # kye가 name인 value를 가져오라

####################################################################

# data frame
# matrix와 같은 2차원 형태의 자료구조
# 다른 데이터 타입을 사용할 수 있음
# column명을 이용할 수 있음
# Database의 Table과 유사!
# list와 vector를 혼합한 자료구조

# 간단한 예 이용해 보기

  # 1) vector를 이용해 data frame 만들기

    no = c(1,2,3) # 열별 데이터 준비
    name = c("홍길동", "김길동","최길동")
    age = c(10,20,30) 
    
    df= data.frame(s_no=no,
                   s_name=name,
                   s_age=age) # data frame 만들기 
                              #data.frame(매트릭스 열이름 = 넣을 변수 이름)
                              # (약자로 df를자주사용)
    df
    df[1]     # 첫 번째 열을 불러오는 방법
    df$s_name # dataframe에서는 column명을 지칭해 자료를 불러온다
               # 주의. $는 list에서는 키, matrix에서는 column명 지칭
    
  # 2)  matrix를 가져와서 dataframe으로 바로 전환하는 방법. 
        #위 방법과 차이는, 열이름이 기본형으로 들어간다는 점

    myMatrix = matrix(c(1:12),
                  ncol=3,
                  nrow=4,
                  byrow=T)
    myMatrix
    
    df_mat = data.frame(myMatrix)
    df_mat
    
# data frame의 함수
    str(df);  # data frame의 정보/구조를 보여주는 함수
              # obs = 관측치(관찰대상수 = attribute = 행개수)
              # varibables = 변수개수 = 열개수
    summary(df); # data frame의 간단한 요약통계량
    
    df= data.frame(x=c(1:5), # <- 만약 사이즈를1:6으로하면 recycling rule적용이안되면서 에러
                   y=seq(2,10,2),
                   z=c("a","b","c","d","e"))
    df
    
    
    # 연습문제 
    # 주어진 data frame의 1,2번째 column에 대해 각각 합계를 구하시오
      # 나의 첫 솔루션
      apply(X=df[1], MARGIN=2, FUN=sum)
      apply(X=df[2], MARGIN=2, FUN=sum)
      # better 솔루션
      apply(X=df[,c(1:2)], MARGIN=2, FUN=sum)
      apply(X=df[-3], MARGIN=2, FUN=sum)
      # 불가능한 솔루션
      apply(X=df$x, MARGIN=2, FUN=sum)  
          # apply는 행렬구조로 인식하기 때문에 
          #벡터를 가져오는 $를 그대로 사용하면 오류가 남
      apply(X=cbind(df$x,df$y), MARGIN=2 ,FUN=sum)
          #행을 묶어준 다음 실행
      
    
  # subset()
    # data frame에서 조건에맞는 행을 추출해서
    # 독립적인 data frame을 생성
      df= data.frame(x=c(1:5),
                     y=seq(2,10,2),
                     z=c("a","b","c","d","e"))
      df
      
      subset(df, x>3)
      
    # x가 3보다작고 y가 4이상인 데이터를 추출하시오
      subset(df, x<3 & y>=4)
      df_sub <- subset(df, x<3 & y>=4)
      df_sub      
      
###########################################################
      
# 6개의자료구조에 대해 알아봄
# 배운내용을 복습하기 위해서 간단한
# 연습문제를 풀어볼 것
     
# 1. 4,5,5,7,10,9,4, 데이터를 이용해서 
# 숫자형 vector를 생성하시오
X <- c(4,5,5,7,10,9,4) ; X
mode(X)      
is.numeric(X)


# 2. 아래의 두 벡터의 연산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,4)

x1+x2            # 6, 8, 10, 11
                 # recycling rule

# 3. data frame을이용해 다음 결과를 도출하시오
  Age <- c(22,25,18,20)
  name <- c("James", "Mathew", "Olivia", "Stella")
  gender <- c("M", "M","F","F")
  
  # 출력형태
  ##     AGE  Name   Gender
  ## 1   22   James   M
  ## 2   25   Mathew  M

  # My Solution
    df <- data.frame(Age=Age, 
                     Name=name, 
                     Gender=gender)
    df
    
  
    df[c(1,2),]
    subset(df, Age>=22)
    subset(df, Gender!="F")    
    subset(df, Gender=="M")    

# 4. 아래의 구문을 실행한 결과는? Fancy Indexing
    x <- c(1,2,3,4,5)
    (x*x)[!is.na(x) & x>2]
        # (T T T T T) & (F F T T T)
        # (1 3 9 16 25)[(F F T T T)] # Fancy Indexing
        #  --> 9 16 25    
    
    # (1 3 9 16 25)[3]  --> # 9
# 5. 다음의 계산결과는?
    x <- c(2,4,6,8)
    y <- c(T,T,F,T)
    sum(x[y]) 
    

# 6. w제공된 vector에서 결측치(NA)의 개수를
    #구하는 코드를 작성하시오
    var1 <- c(34,55,89,45,NA, 22,12,NA,99,NA,100)
    sum(is.na(Var1))    
    
  # 결측치를 제외한 평균을구하시오
     mean(var1[!is.na(var1)])
     
# 7. 두 개의 백터를 결합하시오
    x1 <- c(1,2,3)
    x2 <- c(4,5,6)
    
    c(x1,x2)
    
    # vector를 결합해서 matrix를 만들어보자
    rbind(x1,x2)
    cbind(x1,x2)     
    
# 8. 다음 코드의 실행 결과는?
    x = c("Blue", 10, TRUE, 20)
    is.character(x) #TRUE
    
    
  
    