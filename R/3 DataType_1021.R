# R의 Data Type #


# DATA Type 이 크게 2가지
    # - 기본데이터 타입
    # - 특수데이터 타입


# 기본데이터 타입#

    # 1. 숫자형(numeric): 정수 실수 포함
    # "L"기호를 이용해 정수, 실수 구분
    100 #정수형 같으나, 기본적으로실수형 숫지로 인식
    100L #정수는 "L"기호를 이용해 정의

    # 2. 문자형(Character) : 하나 혹은 둘 이상의 문자의                집합 (자바는 문자와 문자열인 string을 구문함 )
    "홍길동" # 문자열
    '최길동' # 문자열
    '홍' #문자열
    
    # 3. 논리형(logical) : TRUE(T), FALSE(F)
    
    # 4. 복소수형(complex) : 4-3i 
    
    
    
# 특수데이터 타입 #
    
    # 1. NULL : 객체가 존재하지 않음을 지칭하는 객체
    var1 = NULL
    
    # 2. NA : Not Available : 결측치를 표현할 때 사용
    
    # 3. NaN : Not Available Number 또는 
       # Not A Number (연산이 불가능한 숫자)
    sqrt(-3)
    
    # 4. Inf : 양의 무한대
    # 5. -Inf : 음의 무한대

    
###########################################################

# 데이터 타입 조사
    
var1 = 100
var2 = 100L
var3 = "Hello" # ''와 ""를 혼용X 하나로 통일
var4 = TRUE
var5 = 4-3i
var6 = NULL
var7 = sqrt(-3)


# 데이터 타입 조사

  #데이터 타입을 조사하기 위한 함수의 종류

  # 1.mode()
    mode(var1) # numeric
    mode(var2) # numeric
    mode(var3) # character
    mode(var4) # logical
    mode(var5) # complex
    mode(var6) # NULL
    mode(var7) # numeric (주의)
    
  # 2. is 계열 함수 -> 논리형이므로 TRUE나 FALSE로 나타남
    is.numeric(var1) # true
    is.numeric(var2) # true
    
    is.integer(var1) # false 
    # (형태는 정수이나 R은 L없이는실수로 인식하므로)
    is.integer(var2) # TRUE
    is.null(var2)
    #is 계열 함수는 더 있음

    
# R DATA TYPE의 우선순위(좋은표현 아님)
    # DATA TYPE CASting시 상위 데이터 타입으로 변경됨 
    
    # 총 4가지 데이터 타입 중
    
    # 1순위: "Chracter"
    # 2순위: 복소수 "Complex"
    # 3순위: 숫자형 "numeric"
    # 최후순위: 논리형 "logical"
    
    # 벡터는 1차원 선형의 단일 타입 데이터 구조인데
    myVector = C(TRUE,10,30) 
    myVector
    # numeric으로 통일되어 true는 1로 입력됨
    
    myVector = c(TRUE, 10, 30, "Hello")
    myVector # 모두 문자로 입력
    
    
# 데이터 타입 변경 (Type casting)
    # 데이터 타입을 다른 데이터타입으로 변경가능 
    var1 <- 3.1415926535
    var2 <- 0
    var3 <- "3.1415"
    var4 <- "Hello"

    # 데이터 타입 변경시 as계열 함수 사용
    as.character(var1) # "3.1415" #character로 변경
    as.integer(var1)   # 3        #integer로 변경
    as.logical(var2)   # FALSE    # 0제외 나머지는 TRUE
    as.double(var3)    # 3.1415   #실수형으로 바꿔라 
    

###################################################
    
