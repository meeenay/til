#10/31(목)
# - Kakao API(이미지 검색) + 찾은 image 파일로 저장
# - Selenium을 이용한 동적 데이터 Crawling
# - 공공데이터포탈 (www.data.or.kr)
# - 데이터 전처리 



##########################################################
# [KAKAO API(이미지검색)로 이미지 찾고 파일로 저장하기]
# 이미지 검색을 위한 kakao 데이터에 대한 이해가 선행되어야 함
# 
# Tip. 로직 보다는 함수활용에 집중하는 R로 진행 할 예정
# 이용 패키지 : 
# network연결을 통해 서버에 접속해 결과를 받아올 때 가장 일반적으로 많이 사용하는 package를 이용


getwd()
setwd("C:/r_lecture/")
.libPaths("C:/r_lecture/lib")

getwd()

install.packages("httr")
library(httr)
library(stringr)


#Open API의 주소를 알아야 호출한다 
url <- "https://dapi.kakao.com/v2/search/image";

keyword <- "query=아이유";

request_url <- str_c(url,
                     "?",
                     keyword);
request_url <- URLencode(request_url)



# Open API를 사용할 때 거의 대부분 인증절차를 거쳐야
# 사용할 수 있다

# 3.클라이언트가 서버쪽 프로그램을 호출할 때 몇 가지 "호출방식"이 있다. 
# 기본적으로 총 4가지의 Rest 타입(모두를 이용하는 타입)
# 이 중에서도 일반 서버 호출에는 GET과, POST 중 한 가지 방식을 사용한다
# (1) Get : 서버 프로그램에 호출 할 때 전달 데이터를 URL 뒤에 붙여 전달 (지금까지 활용한 방식)
# 단점: 전송 데이터 사이즈에 제한이 있다 (URL의 길이가 유한하므로) 
# 이미지, 파일의 대용량 데이터는 서버쪽에 데이터로 전달 할 수 없다 -> Post 또는 다른 방식 이용
# (2) Post :  서버 프로그램을 호출할 때 전달 데이터가 request header에 붙어서 전달 된다
# - request url뒤에 붙는게 아니라, 다른 방식으로 묶여서 전달 된다. (요청 헤더 안에 데이터를 붙여 전달)
apikey <- "81efb179572cd6483fd49492cdbb66bb"

result <- GET(request_url,
              add_headers(
                Authorization=paste("KakaoAK",
                                    apikey)))
              
http_status(result) # 접속상태 결과

result_data <- content(result) # httr패키지가 결과내용을 추출하는 함수
result_data;

View(result_data)


####thumnail 주소 가져오기 ###
for (i in 1:length(result_data$documents)){
  req[i] = result_data$documents[[i]]$thumbnail_url
}


#### thumnail 주소로 이미지 컴퓨터에 저장하기
for (i in 1:length(result_data$documents)){
  req = result_data$documents[[i]]$thumbnail_url
  res = GET(req) # 이미지에 대한 응답
  imgData = content(res,"raw")  
  #결과로 받은 이미지를 raw형태로 추출. binary data
  # (동영상, pdf, 이미지) 형태로 얻기위해 반드시 필요
  writeBin(imgData,
           paste("C:/r_lecture/image/img",
           i,
           ".png"))
            # img1.png
}

####header 안의 인증 코드를 넣기 위해 from jason 대신
####httr을 이용해 jason데이터를 가지고 온 것
####from jason 은 데이터를 가져올 때 데이터 프레임으로 바로 가져오는 특성

###httr은 content를 사용해야 data frame형태로 가져올 수 있다.



###############################################################
# Selenium을 이용한 동적 page scraping
# Selenium을 R에서 사용할 수 있게 도와주는 package 설치

install.packages("RSelenium")
library(RSelenium)
# R 프로그램에서 Selenium Server에 점속한 후
# remote driver 객체를 return 받는다


remDr <- remoteDriver(remoteServerAddr ="localhost",
             port=4445,
             browserName = "chrome")# R셀레니움이 가지고 있는 접속 함수)

remDr

# 접속이 성공하면 remote driver를 이용해서 
# chrome brower를 R code로 제어할 수 있다

# Browser open
remDr$open()

# open 된 browser의 주소를 변경하라
remDr$navigate("http://localhost:8080/bookSearch/index.html")

#입력상자를 찾아라
# css selector를 이용하여, type이 text인 것을 찾겠다
inputBox<-remDr$findElement(using="css", 
                  "[type=text]") 

#찾은 입력상자에 검색어를 넣기
inputBox$sendKeysToElement(list("여행"))
# list로 넣는 이유는 값을 여러 개 넣을 수 있기 때문

#AJAX호출을 하기 위해 버튼을 먼저 찾아야 한다
btn <-remDr$findElement(using="css", 
                                  "[type=button]") 
# 찾은 버튼에 click event 발생
btn$clickElement()

# AJAX 호출이 발생해서 출력된 화면에 필요한 내용 추출
li_element <- remDr$findElements(using="css",
                                 "li")


# 이렇게 얻어온 element 각각에 대해 함수를 호출
myList <- sapply(li_element,function(x){
      x$getElementText()
})
      # sapply : 적용함수. 요소 각각에 대해 함수를 적용한다
      # myList : 리스트로 도출됨
myList

for(i in 1:length(myList)){
  print(myList[[i]])
}







