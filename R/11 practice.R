# 연습문제 

# 사용할 데이터 : 2 3 5 6 7 10

# 1. 주어진데이터로 vector X를 생성하시오
x <- c(2,3,5,6,7,10); x


# 2. 주어진 데이터 각각을 제곱해서 vector X를 생성하시오
x <- c(2,3,5,6,7,10)^2 ; x

# 3. 주어진 데이터를 각각 제곱해서 합을 구하라
sum(c(2,3,5,6,7,10)^2);

# 4. 주어진 데이터에서 5보다 큰 값들로 구성된 vector x를 구하시오
x <- c(2,3,5,6,7,10)[x>5]
x[c(x>5)]

x <- c(2,3,5,6,7,10)
x[x>5]

x <- c(2,3,5,6,7,10)
var1<- c(2,3,5,6,7,10) > 5 # mask
x[var1] # fancy indexing

# 5. vector x의 길이를 구하시오
x = c(2,3,5,6,7,10)
length(x)

# 6. R의 package 중에 UsingR을 설치하자(이용가능한데이터셋이 있는 연습 패키지)
install.packages("UsingR")
library(UsingR)

# data함수로 데이터를 불러들일수 있음
data("primes");
# 1부터 2003까지 숫자 중 prime number를 가지고 있음
head(primes) # 앞에서 6개만 출력
tail(primes) # 뒤에서 6개만 출력 


# 7. 1부터 2003까지 숫자 중 Prime number는 몇개인가?
length(primes)


# 8. 1부터 200까지 숫자 중 prime number는 몇 개?
length(primes[primes<=200])
#또는 
sum(primes<201)


# 9. 평균을 구해보자
mean(primes)

# 10. 500이상 1000이하의 prime number만으로 구성된
    # vector p를구하시오
    # fancy indexing을 이용해보자
p <- primes[primes>=500 & primes<=1000] ;p


#############다음 형태의 데이터를 이용해 
#     아래의 문제를 풀어보자

# 1 5 9 
# 2 6 10
# 3 7 11
# 4 8 12

# 11. matrix 를 만들어보자


a <- c(1,5,9)
b <- c(2,6,10)
c <- c(3,7,11)
d <- c(4,8,12)
x <-rbind(a,b,c,d);x


X <- matrix(seq(1,12),
          nrow=4,
          ncol=3,
          byrow=F)
X


# 12. 전치행렬을 만들어 보자


t(X)


# 13. matrix x에 대해 첫번째 행만 추출하시오


X[1,]

# 14. matrix x에 대해 6,7,10,11을 matrix형태로 추출하시오

X[c(2,3),-1]


# 15. matrix x에 대해 x의 두번째 열의 원소가
# 홀수인 행들만 뽑아서 matrix p를 생성하시오

p <- X[X[,2]%%2==1,]
p



############### 프로그래밍 ####################

## 홀수개의 숫자로 구성된 숫자문자열이 입력으로 제공됩니다
## 문자열의 개수는 7개 이상 11개이하로 제한됨
## 즉,입력 문자열의 길이는 7개, 9개, 11개 임

## 중앙 숫자를 기준으로 앞과 뒤의 숫자를 분리하고, 
## 분리된 두 수를 거꾸로 뒤집어서 두 수의 차를 구하시오
## 예 ) 7648623
## 764, 623
## 467 326
## 467-326 두 수의 차이를 구하라

## 467-026 (467-26)

library(stringr)

###선생님 솔루션 쓰다 맘 #####

library(stringr)
input = "7648623"
mid_input=(str_length(input) %/% 2) + 1
var1 = str_sub(input,
               1,
               mid_input-1)
var2 = str_sub(input,
               mid_input+1,
               str_length(input))
abs(
  as.integer(paste(rev(str_split(var1,pattern = "")[[1]]),collapse = ""))
  -
    as.integer(paste(rev(str_split(var2,pattern = "")[[1]]),collapse = ""))

### 나의솔루션#### 망함

myLength <- str_length(input)

x <- str_sub(input,1,myLength%/%2)
y <- str_sub(input,(myLength%/%2)+2,myLength)

xLength <-str_length(x)
yLength <- str_length(y)

for (var1 in xLength:1) {
     paste(str_sub(x,var1,var1)), collapse = ""}


paste(var1, collapse = "-"
      
      var1 = c(str_sub(x,xLength)-

                 
#######################################################
# 기본적인 R사용
# data type (자료형)
# data structuree (자료구조)
# control statement (제어문)

# web
# 데이터를 구축
# Database로 부터 데이터를 얻어올 수 있다
# Open API를 이용해서 데이터를 얻어올 수 있다 #공개프로그램
# 파일로부터 데이터를 얻어올 수 있다
# 프로그램적으로 web scraping, crawling을 통해 데이터구축


# HTML, CSS, JavaScript
  # HTML : 웹페이지의 내용, 구조를 담당
  # JavaScript :웹페이지의 동적처리 담당
  # CSS: 웹페이지의 Styling을담당

# 기본적으로 web은 CS구조로 이루어져있음
# CS구조:client -server구조
      # server쪽 프로그램 :web server
      #                   HTML, CSS, JavaScript를 제공해줌
      # client쪽 프로그램: chrome(browser)
      # 서버로부터 자바스크립트를 받아 화면에 rendering함

# HTML, CSS, JacaScript를 이용해 
# 클라이언트에게 제공해주는 web page를 만들어 보자
# 개발 툴이 있어야 함
# webStorm 을이용해 개발해보자

# 클라이언트에게 제공할 HTLM을 작성했음
# 서버프로그램(web server)에게 우리 프로젝트를 알려줘야함
# 우리 프로젝트를 web server에게 인지시켜야한다(configure)
# web server 프로그램을 기동시켜서 우리 프로젝트를 웹에 deploy 시킴
# web client(browser)를 이용해서 URL(주소, 좌표)를 이용해 서버 쪽 프로그램에 
# 접속해서 HTML을 받아가서 화면에 그린다(표시한다)
# Web server가 web storm에 내장되어있음!



# 10/25 금

#   - kyeworkd로 도서 검색후 출력(실습)
# Web crawling & web scraping



### HTML, CSS, JavaScript 웹 언어

# w3c
# HTML이 발전발전 해서 1999년 4.01 버전
# W3C가 1999년 12월에 HTML 4.01을 마지막으로
# 더이상 HTML의 버전업은 없다고 발표함
# HTML 언어는 기본적으로 2가지 문제점을 가지고 있기 때문임

# HTML의문제점
  # 1. 정형성이 없음 : error가 있어도 알아서처리 하여 수행 해 줌 
  #                   주기적 유지보수 및 업데이트 시 구조적 문제가 대두됨
  # 2. 확장성이 없다  -> 태그의 기능이 고정됨 
  #                   (배우기는 쉬우나, 정해진 기능을 벗어날 수 없는 한계) 
  # 2000년 부터 W3C는 HTML 표준을 다른 것으로 가미해 
  # 위 2가지 문제를 해결하기 위해 
  # XML을 HTML에 도입해서 표준으로 끌고가려 함
  #    1. 정형성이 있고, 2. 확장성이 있음
  # XHTML 1.0 이 시작 => but실패 (배우고 사용하기 어려움)
  # XML 사용에 회의적인 시각을가진 몇몇 회사들이 컨소시엄을 구성하여 
  # XML대신 HTML을 발전시키기로 했고
  # HTML 5를 개발함

# HTML5 의의: 
  # 웹페이지 대신 웹어플리케이션이 대세가 될거라는 시각으로 개발 
  # 웹 창이 응용프로그램 처럼 열림
  #	웹페이지 대신 Front-End Web Application을 사용하게 될 것이라 예상
  # Angular, react.js,View.js (Front-End쪽 Frame work) 
  # => JavaScript 언어를 이용해 웹 페이지가 아닌 웹 어플리케이션을 만들고 있는 추세

  # * 본 과정에서는 HTML5를 사용하나, 웹어플리케이션이 아닌 웹 페이지를 base로 학습할 것
  # 


rm(list=ls())