####################제어문 #####################
# R은 프로그래밍 언어. 따라서 제어문도 가지고 있음
# 제어문이란?

# if구문 (조건문)
var1 = 100
var2 = 20


# 조건에 따라서 실행되는 code block을 제어할 수 있음

# 예)

if(# 조건입력란
  var1>var2){
  # 조건문이 참일때 실행
  cat("참이에요!!")
} else {
  # 조건문이 거짓일 때 실행
  cat("거짓이에요!!")
}

# ifelse : 3항 연산자

var1 = 10
var2 = 20

ifelse(var1>var2, "참일경우 선택", "F일경우 선택")
    # if문의 축약형
ifelse(var1>var2, "참", "거짓")



# tip: R에서 제어문이큰 비중을 차지 하지는 않음.프로그래밍언어를 쓰는 것보다 함수를써서 데이터를 다루는게 낫기 때문
###################반복문 ########################

## 반복문 (for, while)

# for: 반복 횟수만큼 반복 실행
# while: 조건이 TRUE일 동안반복 실행


# for(변수명 in )  # for in구문이라고함
for(var1 in seq(1:5)) { #in뒤의 수 처음부터 var1에넣음
  print(var1) # 명령어를 시행함 ->화면에 1이 출력
}

# while
idx = 1 
mySum = 0

while(idx <10){
  mySum = mySum +idx #line하나를 statement 1개로 인식
  idx = idx +1      # 한 줄에입력하려면 ;으로 구분
 }
mySum # 45 (1부터 9까지 더하기)


#로직(제어문)을 이용해서 1부터 100사이에 있는 3의 배수를 출력하세요

library(stringr)
idx = 1
while(idx<100) {
      if(idx%%3==0{
        cat(str_c(idx,", "))
        }
        idx = idx +1
}

for(idx in seq(1,100)){
  if(idx %% 3 ==0){
    print(idx)}}
  

# 1부터 100 사이에있는 prime number를 출력하라
#????????????????????????????????????????????

idx<100
x=2
while(idx<100){}
if(idx%%x!=0){print(idx)}
x = c(x:x + 1)


# 사용자 정의 함수
# 제공된 함수 말고 우리가 함수를 만들 수 있을까? 

# 함수명 <- function(x) {...}
          #function(x,y,z) :입력인자의 개수만큼
# 입력받은 숫자를 제곱해서돌려주는 함수를 
# 하나 만들어보기

myFunc = function(x) {
  x = x * x
  return(x)}# 처리한 결과를 돌려주기
}
myFunc(5)


# sum함수와 동일한 역할을 하는 mySum을 만들어보자
# vector를입ㄺ으로 받아서 합을 구해주는 함수

var1 = c(1:10)
sum(var1)


mySum = function(x) {
  result = 0
  for(t in x) {
    result = result + t
  }
  return(result)
}
mySum(var1)


###########################################
# 오후 ....
# 연습문제를 풀어볼 것
# 로직 문제를 풀어보자

# Web (내일까지 이어서)




