#####복습및 연산자 학습####################

# Operator

var1 = 100
var2 = 3

result<- var1 / var2
result

# 출력형태 변경 
  #출력길이 기본값은 7이다
    options(digits = 5) 
    # 출력형태 설정. 5자리 숫자
    sprintf("%2.7f") 
    #  실수부분 2자리 소수부분 8에서 반올림해
    #  7자리로 출력. 결과는 문자로 떨어짐

var1 %/% var2 #33 <-몫
var1 %% var2  #1   <-나머지

#비교연산자
var1 == var2  # FALSE <-같니?
var1 != var2  # TRUE  <- 같지 않니?

########################################### 

# DATA TYPE
  # 기본데이터 타입 4가지
    # 1. character("",'') 2. complex 3. numeric
    # 4. logical

  # 특수데이터 타입4가지
    # NULL, NA, NaN, Inf


# 데이터 타입을 알아보는 함수 ==> Mod(), is.함수()
  var1 ="이것은 소리 없는아우성!"
  mode(var1)
  is.character(var1)
  is.null(var1)
  is.na(var1)


# 데이터 타입을 변경할 수 있다
  # as 계열의 함수 이용
  var1 ="3.141592"
  as.double(var1) # <- 실수로 변경
  var2 = TRUE
  as.numeric(var2)
  
  var3 = 100
  as.logical(var3)
  
###############################################
