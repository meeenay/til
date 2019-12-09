############# 데이터 조작################3
# dataframe을 생성한 수 사용ㅇ하는 함수


getwd()
setwd("C:/r_lecture/")
.libPaths("C:/r_lecture/lib")

rm(list=ls())


iris 
# iris: 붓꽃의 종류와 크기에 대해 측정한 데이터로
# 통계학자 피셔라는 사람이 측정해 제공
# R에 내장됨
# 컬럼
View(iris)



# 기본함수
# 1. head : 데이터 셋의 앞에서부터 요청개수만큼의 데이터를 추출한다 default= 6개
#          데이터프레임이 아닌 경우도 적용된다.
head(iris)
head(iris,3)

var1 <- c(1,2,3,4,5,6,6,7)
head(var1)

# 2. tail(): 데이터 셋의 뒤에서부터 데이터를 추출한다. 디폴트값은 6개. 데이터프레임 외에도 적용 가능하다.
tail(iris,n=3)

# 3. View(): view창에 데이터 출력
View(iris)

# 4. dim(): data frame에 적용할 때 행과 열의 개수를 알려줌
dim(iris)  # 150 5
var1 <- c(1,2,3,4,5,6,6,7)
dim(var1)  # null # 선형자료구조(vector, list)에는 사용할 수 없다.

# 5. nrow() : 행의 개수 구하기

# 6. ncol() : 열의 개수


# 7. str() : data frame에 대한 일반적인 정보를 추출
str(iris)

# 8. summary() : data frame의 요약통계량
# Min, Max, 사분위, 평균(mean), 중간 값(Median)
summary(iris)

#9. ls(): data frame의 column명을 vector로 추출

ls(iris)

# 10. rev()
# 선형자료구조 데이터를 역순으로 정렬

# 11. length()
  # 주의사항
  # 선형자료구조: 길이를 도출
  # data Frame : 컬럼의 개수
  # Matrix : 원소의 개수


##########################################
#PLYR PACKAGE =>dplyr 개량형 package

install.packages("plyr")
require(plyr)


# 1. key값을 이용해 두 개의 data frame을 병합
#  (세로방향, 열방향으로 결합)
# 주의사항: R에서는 LeftJoin이 default

#data frame을 두 개 만들어 결합해보기

# key 1개를 이용한 결합
x = data.frame(id = c(1,2,3,4,5),
               hight = c(150,190,170,188,167))

y = data.frame(id = c(1,2,3,6),
               weight = c(50,100,80,78))

join(x,y,by="id", type="inner") # join(결합변수1,변수2,type="",by="키")
join(x,y,by="id", type="left")  # default
join(x,y,by="id", type="right")
join(x,y,by="id", type="full")



#key 2개를 이용한 결합
x = data.frame(id = c(1,2,3,4,5),
               gender = c("M","F","M","F","M"),
               hight = c(150,190,170,188,167))

y = data.frame(id = c(1,2,3,6),
               gender =c("F","F","M","M"),
               weight = c(50,100,80,78))


join(x,y,by=c("id","gender"), type="inner") # join(결합변수1,변수2,type="",by="키")
join(x,y,by=c("id","gender"), type="left")  # default
join(x,y,by=c("id","gender"), type="right")
join(x,y,by=c("id","gender"), type="full")

#dplyr 에서는 join() ==> left_join()



# 2. 범주형 변수를이용해 그룹별 통계량 구하기 

# 1) 범주의 종류 파악하기
str(iris)

unique(iris$Species) # 중복제거 후 남은 것 알려주기
                    # 특정 변수의 값 목록을 알 고 싶을 때 사용하기 좋음 

    # str은 모두 다 나오는데, 100개가 넘는 열이 있는 경우 복잡하므로, 
    # 대량의 데이터에서는 unique 함수를 이용해 데이터 값들을 
    # 찾아내는것이 편리하다


# 2) iris의 종별 꽃잎 길이의 평균을 구하라
# tapply(대상 column,기준,적용함수) == (꽃잎 길이, iris범주형변수 column, mean)

tapply(iris$Petal.Length,
       iris$Species,
       FUN = mean);

tapply(iris$Petal.Length,
       iris$Species,
       FUN = max)

# ddply(): 한번에 여러개의 통계치를 구할 수 있다
df<-  ddply(iris,                      # 데이터
          .(Species),                  # 기준변수 (범주형)
          summarise,                   # 요약통계
          avg = mean(Petal.Length),    # 산출값1
          sd = sd(Petal.Length))       # 산출값2

class(df)  # 데이터 프레임으로 떨어짐
View(df)   



##################################################
##plyr에서는 join()과 통계값을 구하는 함수
## (2개)aks dkfdkenaus ehlsek

## 실제로 data frame을 핸들링 할 때는
## plyr 을 개량한 dplyr을 이용한다
## dplyr은 C++로 구현되었기 떄문에 속도가 빠르고
## 코딩시 chaining을 사용할 수 있다


# chaining이란?
#  일반적으로연속 프로그래밍을 위해서는 다음과 같이 변수를 생성하는데
var1 <- c(1,2,3,4,5) 
var2 <- var1 *2

# chaining에서는 변수의 생성 없이 한 줄로 만들어 낼 수 있다 
#  틀린 문법이지만, 예컨대 아래와 같은 개념이다.
var1 <- c(1,2,3,4,5) >> *2 >> +5




### 패키지 설치
install.packages("dplyr")
library(dplyr)



# dplyr의 주요함수들

# table_df() : 현재 console 크기에 맞추어서 data frame을 추출하는 함수

tbl_df(iris)



# 강사님이 제공한 excel 파일을 dataset으로 이용해보자
install.packages("xlsx")
library(xlsx)
excel <- read.xlsx(file.choose(),
             sheetIndex = 1,
             encoding = "UTF-8")

excel
str(excel)
ls(excel)
tbl_df(excel)
  # 제공된 excel을 읽어보니 data frame을 생성한 후 column명을 보니 
  # Amt17 : 2017년도 이용금액
  # Y17_CNT : 2017년도 이용횟수
  # 통일해 주자


# 2. rename() : column명 변경
#   rename(data frame,
#                   바꿀 컬럼명1 = 이전컬럼명1,
#                   바꿀 컬럼명2 = 이전컬럼명2,....)
# column명을 수정한 새로운 data frame이 return됨
# 기존 데이터 프레임이 변경 되는 것이 아니다!

df <- rename(excel,
             CNT17 = Y17_CNT,
             CNT16 = Y16_CNT)
tbl_df(df)


# 3. 하나의 data frame에서 하나 이상의 조건을 이용해서 데이터를 추출하려면 ?
# filter(data frame,
#             조건1, 조건2,...)
# 성별이 남자만 추출
filter(excel,
       SEX == "M")

# 성별이 남자이면서 서울 거주자만 추출
filter(excel,
       SEX == "M",
       AREA =="서울")
filter(excel,
       SEX == "M" & AREA =="서울") # 하나의 조건으로 인식

## 모든 사람들 중에 지역이 서울 혹은 경기인 남성들 중 40살 이상의 사람들의 정보 추출
filter(excel,
       AREA =="서울" | AREA == "경기",
       AGE >= 40,
       SEX == "M")

## 모든 사람들 중에 지역이 서울 혹은 경기 혹은 제주인 남성들 중 40살 이상의 사람들의 정보 추출
## 가독성 높은 표기법
filter(excel,
       AREA %in% c("서울", "경기","제주"),
       AGE >= 40,
       SEX == "M")


# 4. arrange(data frame,
#                     column1, column2,...)
# 정렬의 기준은 오름차순 정렬
# 만약 내림차순으로 정렬하려면 desc()

## 서울사는 남자. 2017년 처리금액이 400,000원 이상인 사람을 나이가 많은 순으로 출력하라

df<-filter (excel,
        AREA =="서울",
        SEX =="M",
        AMT17>=400000)

arrange(df,desc(AGE))


# Chaining 기호 : %>%
df<-filter (excel,
            AREA =="서울",
            SEX =="M",
            AMT17>=400000) %>%
  arrange(desc(AGE))

df


# 5.Select(column1, column2...)
# 추출하길 원하는 column을 지정해서 해당 
# Column만 추출할 수 있다

# filter는 레코드 선택, selects는 컬럼을 선택

# 서울살고 남자, 2017년 처리금액이 400,000원 
# 이상인 사람을 나이가 많은 순으로 
# ID와 나이, 그리고 2017년도 처리 건수만 출력

df1<- filter(excel,
             AREA =="서울",
             SEX =="M",
             AMT17>=400000) %>% 
      arrange(desc(AGE)) %>%
      select("ID", "AGE", "Y17_CNT")


 # select로 연속된 열을 뽑을 때
df1<- filter(excel,
             AREA =="서울",
             SEX =="M",
             AMT17>=400000) %>% 
  arrange(desc(AGE)) %>%
  select(ID:AGE) # 또는"ID" : "AGE

 # 특정 열을 제외하고 뽑을 때
df1<- filter(excel,
             AREA =="서울",
             SEX =="M",
             AMT17>=400000) %>% 
  arrange(desc(AGE)) %>%
  select(-SEX) # 또는 -"SEX"

df

# 6. 새로운 column을 생성할 수 있다
# 만들려는 column의 이름을 $뒤에 작성해주면 됨
# 구매금액이 50만원이 넘는 사람을 정해 VIP로 등극



excel$grade <- ifelse(excel$AMT17>=500000,
                      "VIP",
                      "NORMAL")
View(excel)

# dplyr  함수로 새 컬럼 만들기 
# mutate(data frame, 
#       컬럼명1 = 수식1 또는 값,
#       컬럼명2= 수식2)

# 경기사는 여자를 기준으로 2017년도 처리금액을 이용하여 
# 처리금액의 10%를 가산한 값으로 
# 새로운 컬럼 AMT17_Real을 만들고 
# AMT17_Real이 45만원 이상인 경우 
# VIP컬럼을 만들어서 TRUE, 그렇지 않으면 FALSE를 입력하라

df <- mutate(excel,
       AMT17_real = AMT17*1.1) %>%
        mutate(vip = ifelse(AMT17_real>=450000,
                      "TRUE",
                      "FALSE"))

df <- filter(excel, AREA=="경기" & SEX=="F") %>%
      mutate(AMT17_REAL = AMT17*1.1, 
             VIP = ifelse(AMT17_REAL >= 4500,
                          TRUE,FALSE))

 ## 함수 내에서 값 ASSIGN을 할 때는 <-를 사용할 수 없다
  #  = 만 제대로 작동
 # ## chaning을 통해 변수를 생성하고 생성한 변수를 바로 활용
 #    하려 할 때, R기본 방식($)은 R이 구문의 요청사항을 제대로 인식하지 못하는
 #    경우가 많다. 따라서 mutate를 반드시 사용해야 한다
 # chaining을 할 때 반복 사용되는 data frame명은 다시 작성하지 않는다



# 7. group_by() & summarise()
df <- filter(excel,
             AREA=="서울" & AGE>30) %>%
      group_by(SEX) %>%
      summarise(        #그룹별 통계를 넘긴다  
        sum= sum(AMT17),#sum이란 컬럼을 만들어서 AMT17의 합을 넣고 ,
        cnt=n())        #cnt라는 변수를 만들어 빈도수를 넣어라

# 8. join함수가 각 기능별로 독립적인 함수로 제공된다
left_join()
right_join()
inner_join()
full_join()

# 9. bind_rows(df1,df1)
# 주의할 점은 컬럼명이 같아야
# 생각하는 것처럼 data frame이 결합한다

# 컬럼명이 같을 때
df1 <- data.frame(x=c("a","b","c"))
df1
df2 <- data.frame(x=c("d","e","f"))
df2
df3 <- bind_rows(df1,df2)                                        
df3
  # 컬럼명이 다를 때 
df1 <- data.frame(x=c("a","b","c"))
df1
df2 <- data.frame(y=c("d","e","f"))
df2
df3 <- bind_rows(df1,df2)
df3


##################################################
# 연습문제를 풀어보자!!
# MovieLens Data Set을 이용해서 처리해보자

#영화에 대한 평점 정보를 기록해 놓은 데이터
#평점은 1~5점(5점이 최대)
#사람이 한 두명이 아님
#영화의 종류도 굉장히 많다

# 데이터를 받았으면 데이터의 구조 확인
# 컬럼의 의미 파악

moviert <- read.csv(file.choose(),
                    encoding="UTF-8")


movielist <- read.csv(file.choose(),
                      encoding = "UTF-8")


# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
#   mean(rating)

View(mean(moviert$rating))


# 2. 각 사용자별 평균 평점

nmovielist<- ddply(moviert,
            .(userId),                             
             summarise,                  
             rtmeanbyuser = mean(rating));
View(nmovielist)

#### gourp by 사용 ### (미완 - 오류)
mode(moviert$userId)
moviert$userId <-as.character(moviert$userId)
mode(moviert$userId)
View(moviert)

group_by(moviert$userId) %>%
              summary(meanbyuser = mean(rating))


# 3. 각 영화별 평균 평점
rtmeanbymovie <- ddply(moviert,
                       .(movieId),
                       summarise,
                       meanrt = mean(rating));
View(rtmeanbymovie)
 
# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력
#    (동률이 있는 경우 모두 출력)

####ID가 맞지 않는 오류가 나타나 아이디 정렬

help(left_join)

rename(rtfrmeanbymovie,
             movieid = movieId)
rename(movielist,
       movieid = movieId)
rename(moviert,
       movieid = movieId)

##### character형으로 모두 변경

rtmeanbymovie$movieId <-as.character(rtmeanbymovie$movieId)

##### 결합 
rtmeanbymovie<-left_join(rtmeanbymovie,movielist, by=rtmeanbymovie$movieid)

title_arranged <- filter(rtmeanbymovie,
                  meanrt==max(meanrt),
                  ) %>%
                   arrange(desc(title))
  
View(title_arranged)


# 5. comedy 영화 중 가장 평점이 낮은 영화의 제목을 오름차순으로 출력
#    (동률이 있는 경우 모두 출력)


comedy <- filter(rtmeanbymovie,
                 meanrt==min(meanrt) & 
                 grepl("(?i)comedy", genres)==TRUE) %>%
      mutate(title = title,
             meanrt = meanrt,
             genres = genres)
View(comedy)



#comedy 포함 문자열 확인 방법 
View(grepl("(?i)comedy", rtmeanbymovie$genre)) 



# 6. 2015년에 평가된 모든 로맨스 영화의 평균 평점
##### character형으로 모두 변경



rom2015 <- mutate(moviert,
                   date = as.Date(as.POSIXct(timestamp, 
                                         origin="1970-01-01"))) %>%
            inner_join(movielist, by="movieid") %>%
            filter(grepl("(?i)romance", genres)==TRUE,
                    grepl("(?i)2015", date)==TRUE) 

meanRo2015 <- mean(rom2015$rating)
 
View(meanRo2015)      



