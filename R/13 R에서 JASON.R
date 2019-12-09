getwd()
setwd("C:/r_lecture/")
.libPaths("C:/r_lecture/lib")

#JSON처리 대표적인 패키지를 설치 및 로드해준다
install.packages("jsonlite")
library(jsonlite)
# network관련된여러 함수들, dependency로 묶여있는 함수들을 모두 같이 설치하는 패키지
install.packages("httr") 

#문자열 처리위해 package loading
library(stringr)

url <- "http://localhost:8080/bookSearch/search?keyword="

request_url <-str_c(url,
                    scan(what=character())
                    )
request_url <-URLencode(request_url)  # 한글 인코딩 처리
request_url
# 주소가 완성되었음 (한글 -> 코드화)


df<-fromJSON(request_url) #변수에 담긴 주소를 사용해 JSON을 가지고 오라--> Table형태로 떨어짐
df

View(df) #테이블 형태로 보는 방법 -> data frame구조를 눈으로 확인 

str(df) # str() :data frame의 구조를 보여줌
names(df) # column명을 가져오기 (key값 확인)


# 찾은 도서 제목만 console에 출력해보자 


for(idx in 1:nrow(df)) { # 행의 개수만큼
 print(df$title[idx]) #data frame에서 title 벡터를 떼오는 것
}


# JSON을 이용해서 Data Frame을 생성할 수 있다
#  data frame을 CSV(comma seperated value)형식으로 file에 저장
write.csv(df, 
          file = "C:/r_lecture/data/book.csv",
          row.names = FALSE,
          quote = FALSE)


# JSON : df로 바꾸지 않고, 서버의 JSON을 직접 이용하고 싶다면
# Data frame을 JSON으로 변경하려면 어떻게 해야 할까? 

df_json <-toJSON(df);#해당데이터를 JSON문자열로 바꿔주는 함수
df_json # 순수JSON으로 표현됨

#이를 예쁘게 표현하는 방법은 prettify함수사용
prettify(df_json)

#일반적으로 json을 저장할 땐 용량이 적은 순수JSON을 사용한다 
write((df_json),file="C:/r_lecture/data/book_json.txt")
write(prettify(df_json),file="C:/r_lecture/data/book_json.txt")



########################연습문제########################    

# 2018년 10월 30일 박스오피스 순위를 알아내서 
# 제목과 누적관람객수를 CSV파일로 저장하라


###### My Solution1 : 벡터추출 -> data frame -> 추출 ###

url <- "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=db62ed87727b5b7c84aaec63b8fe8bbf&targetDt="

request_url <- str_c(url,
                     scan(what = character()))
request_url

df <- fromJSON(request_url) ; df

View(df)


movieNm <- df$boxOfficeResult$dailyBoxOfficeList$movieNm
audiAcc <- str_c(df$boxOfficeResult$dailyBoxOfficeList$audiAcc,"명")

result<-data.frame(movieNm,audiAcc)

write.csv(result, 
          file ="C:/r_lecture/data/movieresult.csv",
          row.names = F)



### My solution 2: data fram추출법 1을 이용해 for문 이용하기#####

url <- "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=db62ed87727b5b7c84aaec63b8fe8bbf&targetDt="

request_url <- str_c(url,
                     scan(what = character()))
request_url

rawmovie <- fromJSON(request_url) ; rawmovie

View(rawmovie)

df1 <- rawmovie$boxOfficeResult$dailyBoxOfficeList
df1

df2 <- rawmovie[[1]][[3]]
df2

resultdf <-data.frame(moviename=1, audience=1:nrow(df1))
resultdf

df1
df1$movieNm[3]

for(i in 1:nrow(df1)){
  resultdf$moviename[i] <- df1$movieNm[i]
  resultdf$audience[i] <-df1$audiAcc[i]
}




#############################

resultdf2 <-data.frame(moviename=1, audience=1:nrow(df1))
resultdf2

moviename=c()
audiacu=c()

for(i in 1:nrow(df1)){
  resultdf2$moviename <- append(moviename,df1$movieNm[i])
  append$audience <- append(audiacu, df1$audiAcc[i])
}

##########################################################################
