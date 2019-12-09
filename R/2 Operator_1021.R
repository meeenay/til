# Operator (연산자)

var1 <- 100
var2 <- 3

var1 / var2 # Java언어 => 33
            # R은 마치 실세계의 연산처럼수행 => 33.333
            # 같은 타입의 숫자를 사용하면 아웃컴도 같은 타입 (정수/정수 => 정수)

# 몫 구하기 #
var1 %/% var2 # 33

# 나머지 구하기 #
var1 %% var2 # 1

# 비교연산자 #
#logical type으로 결과가 나타남(일반언어는 불린?타입으로 설정됨. 같은 표현이긴함)
var1 == var2 #FALSE(F) *false(X) <같은가?
var1 != var2 #TRUE (T) *true(X) <같지 않은가?

# 논리연산자 #
# &, && : 양쪽 값이 TRUE이면 TURE (and)
TRUE & FALSE #->FALSE
RUE && FALSE #->FALSE
#둘 다 논리 연산자 AND 연산
# |, ||: 하나라도 TRUE이면결과 TRUE (or)
TRUE | FALSE #TRUE
FALSE || FALSE #FALSE

# R의 자료구조 #

# 단일변수는 1개짜리 공간
# R은 여러가지 자료구조(데이터를 저장하는 구조)가 있음
# 가장대표적인자료구조로 vector가 있음

# vector: 연속적인 자료 공간, 1차원 (다른언어의 array와 같은 형태를 띔)
# 저장공간에 모두 같은 타입의 데이터가 들어감

# vector의 생성방법 : 함수이용
# c() => combine 의 약자
c(10,20,30) # 10 20 30
c(TRUE, 20, 3.14) # 같은 데이터 타입으로 vector생성 (오류가 아님)  즉, 데이터 타입이 다를 경우, 우선순위에 따라함수 안의 값들이 하나의 타입으로 변경됨
# 벡터중에 원소가 하나짜리인 벡터는 scholar라고 함


# 벡터 구조의 논리 연산비교 # 

c(TRUE,FALSE) & c(TRUE,TRUE) # 벡터 연산결과값 벡터
# 벡터를 논리연산 했을 땐, 백터 간의 연산을 출력하게 됨. 즉 TRUE & TRUE, FALSE & TRUE로 계산하는 것
c(TRUE,FALSE) && c(TRUE,TRUE) # 첫번째 요소만& 연산 수행
# && 논리연산자는 scholar연산으로 도출됨. 벡터의 앞쪽에 있는 값 True & TRUE만 실행

c(TRUE, F, TRUE) & C(FALSE, T) 
#FALSE FALSE FALSE -> 연산이 되긴 하나, 오류메세지가 나타남

!c(T,F,T,F)
#-> !는not 연산으로 내용이 역으로로 산출됨


# 다른언어와 마찬가지로 다양한 수학함수를 내장하고 있음

abs(-3)
round(3.1415)
sqrt(100)
