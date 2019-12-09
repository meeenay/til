
getwd()
##################Web crawling ################################

#Web Crawling : 인터넷 상에서 필요한 정보를 읽어와서
#수집하는 일련의 작업(과정)

# Web Scraping
# 하나의 web page에서 내가 원하는 부분을 추출하는 행위
# Web crawling (web spideri)
# 자동화 봇인 Crawler가 정해진 규칙에 따라 복수개의 web페이지를
# browsing 하는 행위

# CSS selector와 Xpath의 병용 
# 일반적으로 Web페이지가 잘 만들어져 있는 경우
# scraping을 할 때 CSS(jQuery) selector를 이용해서 필요한 정보를 추출한다.
# 단, Selector를 이용해 추출하기가 힘든 것들도 있다. 
# 따라서 추가로 Xpath도 이용해 볼 것이다.
# Xpath는 selector와 비슷한 기능을 하는데, XML기반의 다른 표현법이라고 생각할 수 있다.

# 네이버 영화댓글 주소를 가져오면, 소스를 받아오는게 되는데, 
# 프로그램 적으로 자료를 뽑아내려면, 문자열이 아닌 데이터 구조형태로 받아야 함

#서버로 부터 받은 HTML 태그로 구성된 문자열을 자료구조화 시키는 패키지를 이용해야함



# 1.h패키지를 설치한다
install.packages("rvest")
library(rvest)
library(stringr)
library(httr)

# 2URL을 준비한다
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <-"page="
request_url <- str_c(url,"?",page,1)
request_url

#3. 준비된 URL로 서버에 접속해서 HTML을 읽어와서 dorm tree(자료구조로)화 시킨다
html_page = read_html(request_url,encoding = "CP949")
html_page
# naver 영화댓글 페이지가 오래되어, 구버전 한글 인코딩인 CP949를 사용하고 있다.

# 4. CSS=selector를 이용해서 추출하기 원하는 요소 (element)를 선택하자)

nodes = html_nodes(html_page,
           "td.title > a.movie ")
nodes

# 5. tag 사이에 들어있는 text를 추출한다
# html_text() : html 태그 사이에 있는 글자를 가져오는 함수 
# (jquery의 text()같음)
title<-html_text(nodes) 


# 6. selector를 이용해 리뷰 요소(element)를 선택하자
nodes <- html_nodes(html_page,"td.title")
review <- html_text(nodes, trim = TRUE)   #trim 앞 뒤 공백 제거하기 tab이나 n줄바꿈
class(review) #10개 문자열로 구성된 벡터


# 7.필요없는 문자열들을 제거
review <- str_remove_all(txt, "\t")# 특정 패턴에 맞는 문자열을 지우기
review <- str_remove_all(txt, "\n")
review <- str_remove_all(txt, "신고") # 맨 끝의 신고만 삭제하고 싶으나, 
                        # 텍스트 내에 있는 신고도 삭제될 수 있음에 유의
review # span 태그가 없으니까 구조적인 문제가 계속 발생하게 됨


#for 문으로 제거 해보기 
#(review, title)


# 8. 영화 제목과 리뷰에 대한 내용을 추출했음
#   이제 데이터 프레임으로 만들어 주면 좋을 것

df = cbind(title,review)
df

# 9. 이렇게 구축한 데이터를 파일에 저장하자


###############################################################

###########같은 작업을 Xpath로 실행#######

install.packages("rvest")
library(rvest)
library(stringr)
library(httr)

url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <-"page="
request_url <- str_c(url,"?",page,1)
html_page = read_html(request_url)
nodes = html_nodes(html_page,
                   "td.title > a.movie ")
title<-html_text(nodes) 


# Review 부분은 xpath로 가져와 보자

##* 이용하기 
nodes = html_nodes(html_page,
                   xpath='//*[@id="old_content"]/table/tbody/tr[*]/td[2]/text()')

review<-html_text(nodes,trim=T)
review


## for문 이용하기
review = vector(mode="character", length = 10)

for (idx in 1:10) {
  myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                 idx,
                 ']/td[2]/text()')
  nodes = html_nodes(html_page,
                     xpath=myPath)
  txt <- html_text(nodes, trim = TRUE)
  review[idx] = txt[3]
};

review
       
df = cbind(title,review)
View(df)



# 방법2

nodes<-html_nodes(html_page,xpath = '//*[@id="old_content"]/table/tbody/tr[*]/td[2]/text()')



review<-html_text(nodes,trim = T)

View(review)

review<-review[c(1:length(review))%%4==3]

review


########################crawling 처리 ###########################

## 반복해서 page를 browsing하는 crawling까지 포함해보자
## Function을 이용해 일련의 코드 묶음을 단순화 시키자

# 함수 기본 예시
myFunc <- function(idx){
  print(idx)

}

for (i in 1:10) {
  myFunc(i)
}


######## 함수 만들기 #####

extract_comment <- function(idx){
  url <- "https://movie.naver.com/movie/point/af/list.nhn"
  page <-"page="
  request_url <- str_c(url,"?",page,idx) # 페이지번호만 idx로 바꿔준다
  html_page = read_html(request_url,
                        encoding ="CP949") # 끌어올 때, 40번까지만 읽어오는 문제가 있어서 한글 인코딩 구버전으로 변경했더니 작동함
  nodes = html_nodes(html_page,
                     "td.title > a.movie ")
  title<-html_text(nodes) 
  

  review = vector(mode="character", length = 10)
  
  for (idx in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   idx,
                   ']/td[2]/text()')
    nodes1 = html_nodes(html_page,
                       xpath=myPath)
    txt <- html_text(nodes1, trim = TRUE)
    review[idx] = txt[3]
  };
  
  
  df = cbind(title,review)
  return(df)  
}

## 함수를 호출해서 crawling을 해보자
result_df = data.frame();

for(i in 1:10){
  tmp <- extract_comment(i)
  result_df = rbind(result_df,tmp)
}

result_df




############################################################################
##########################연습문제(수행평가 출제 예정)#####################
# 로튼 토마토 사이트에서 
# 2019년 가장인기있는 영화 100개에 대해서
# 
# 영화제목, User Rating, generic.skeleton
# 부분을 추출해서 Data Frame으로 만들고 
# 파일로 출력하라

library(rvest)
library(stringr)
library(httr)

urlmain <- "https://www.rottentomatoes.com/top/bestofrt/?year=2019"

html_page_w <- read_html(urlmain);

nodes <- html_nodes(html_page_w,
                  "td> a.unstyled.articleLink ")

links <- nodes %>% html_attr("href")

url <- "https://www.rottentomatoes.com"

request_url <- str_c(url,links)


#------------------제목----------------

key <- c("title", "userRating", "Genre")



# -------------------------------------------
#-----주소---
html_page = read_html(request_url[1])

#------함수 만들기-----
moviecrawl <-function(rank) {
  #-----주소---
  html_page = read_html(request_url[rank])
  
  #---제목---
  nodes_ttl <- html_nodes(html_page,
                          "h1")[1]
  title<- html_text(nodes_ttl, trim = T)
  #--user rate---
  nodes_rt <- html_nodes(html_page,"strong.mop-ratings-wrap__text--small")[2]
  nodes_rt
  
  rt<-html_text(nodes_rt)
  rtsep<-str_extract_all(html_text(nodes_rt),"[0-9]")[1] 
  rtSepCh <-paste(rtsep[[1]],collapse="")
  
  UserRating <- as.numeric(rtSepCh)
  
  #---Gerne----
  nodes_gr <- html_nodes(html_page,"ul>li:nth-child(2)>div.meta-value>a ")
  genresep <-html_text(nodes_gr)
  Genre <-paste(genresep,collapse=", ")
  
  #indMovie <- c(title, UserRating, Genre)
  indMovie <- data.frame(title, UserRating, Genre)
  
  return(indMovie)
}


#----------------------------------------------------------

# ----------결합방법 1 ---------------
# movieresult_df[]<-moviecrawl(1)

movieresult_df = data.frame();

for(i in 1:length(request_url)){
  movieresult_df<-rbind(movieresult_df, moviecrawl(i))
  # movieresult_df <- cbind(movieresult_df, tempdf)
}

View(movieresult_df)

# -----------결합방법 2---------------------------
movieresult_df<-vector()

for(i in 1:length(request_url)){
  movieresult_df<-rbind(movieresult_df, moviecrawl(i))
  # movieresult_df <- cbind(movieresult_df, tempdf)
}

View(movieresult_df)

#--------------------------------------

write.csv(movieresult_df, file = "C:/r_lecture/data/movieresult.csv")

library(xlsx)
write.xlsx(movieresult_df, file = "C:/r_lecture/data/movieresult.xlsx")

cat("\014")
rm(list=ls())
