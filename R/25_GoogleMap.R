# 구글 지도 서비스를 이용해 보아요!

# Googl Map Platform을 사용하기 위해서는
# 특정 package가 필요해요!

# 이 package가 CRAN에 등록이 아직 안되어 있어요!
# github에 공유되어 있어요!

# VCS( Version Control System )

# 원본 : A
# 홍길동 : A1
# 최길동 : A2

## 덮어쓰기 작업의 효율성에 문제가 발생
# 이런 공동 작업에 대한 문제를 해결하기 위해서 나온게 VCS

# CVSC ( Centralized VCS )
# 소스원본을 중앙 서버가 1개 들고 있고 나머지 사람이 복사본을 가져다가 작업 서버묹에 따라서 작업에 차질

# DVCS ( Distributed VCS )
# 소스 원본을 여러 곳에서 보관
# Git을 이용하면 공동처리가 쉬워져요!
# Git repository( 저장소 )
# 이런 Git Repository를 서비스 해주는 
# 회사가 있어요 => Github

##########################################

# 1. Github에 공유되어 있는 ggmap
# package를 설치해야 해요!

# 버전 특성을 타요!
# package들은 dependency(의존성)에 신경써야 해요
sessionInfo()
# 현재 R 버전이 3.6.1 이에요... 그런데 사용하려는 
# package가 3.5.1버전에서 실행되요!
# 따라서 3.5.1 버전을 다운 ㄱㄱ

# 이제 버전을 맞췄으니 필요한 package를 github에서 다운받아 설치해 보아요!

# install.packages()      # CRAN에서 받아서 설치
# install_github()        # 헐 이런 함수 없음

# install_github()을 이용하기 위한 package 설치
install.packages("devtools")
library(devtools)
install_github("dkahle/ggmap")  # 설치 ㄱㄱㄱ
library(ggmap)
ggmap()

# google api key 받아와야 해요
# 생성한 구글 API Key
googleAPIKey<- "AIzaSyDglY7CpAHJ4UKsORQD6CGpRMtwRO9nBBY"

# 구글 API Key를 이용해서 인증을 받아요!
register_google(key=googleAPIKey)

## seoul에 대한 맵 띄우기
gg_seoul <- get_googlemap("seoul",
                          maptype = "roadmap")
ggmap(gg_seoul)

library(dplyr)
library(ggplot2)

geo_code =geocode(enc2utf8("공덕역"))
geo_code

# google map을 그리려면 위도, 경도가 숫자형태의 vector로 되어 있어야 해요!

geo_data = as.numeric(geo_code) # 숫자로 변환
geo_data

get_googlemap(center = geo_data,
              maptype = "roadmap",
              zoom = 16)%>%
  ggmap()+
  # 지도 위에 ggplot 기능을 부여할 수 있다.
  geom_point(data=geo_code,
             aes(x=lon,
                 y=lat),
             size=5,
             color="red")

##################################################

addr <- c("공덕역","역삼역")
gc =geocode(enc2utf8(addr))
gc

df <- data.frame(lon=gc$lon,
                 lat = gc$lat)

df

# 두지역의 중간점
cen <- c(mean(df$lon),mean(df$lat))
map<- get_googlemap(center = cen,
                    maptype = "roadmap",
                    zoom = 13,
                    markers = gc)
ggmap(map)+
  geom_line(data = gc,
            aes(x=lon,
                y=lat,
                color="red"))

cendf<-data.frame(lon=mean(df$lon),lat=mean(df$lat))
ggmap(map)+
  geom_line(data = gc,
            aes(x=lon,
                y=lat,
                color="red"))+
  geom_point(data=cendf,
             aes(x=lon,
                 y=lat))


# 지하철역 주변 아파트 정보 :
# 서울 열린 데이터 광장

# 아파트 실거래 금액 데이터:
# 국토부 실거래가 공개 시스템

################################################

# 패널 데이터 실습(정형)
# MovieLens(정형)
# 로튼 토마토 크롤링(반정형)
# KAKAO API(반정형)
# 네이버 댓글 크롤링 후 워드 클라우드 (비정형)

# interactive Graph

# package 설치
install.packages("plotly")
library(plotly)

# mpg data set을 이용해서 배기량과 고속도로 연비에 대한 산점도를 그려보아요!

library(ggplot2)
## ex)

df<- as.data.frame(mpg)
head(df)

g<-ggplot(data=df,
       aes(x=displ,
           y=hwy))+
  geom_point(size=3,color="blue")

ggplotly(g)



### practice

addr <- c("공덕역","역삼역")
gc =geocode(enc2utf8(addr))
gc

df <- data.frame(lon=gc$lon,
                 lat = gc$lat)

df

# 두지역의 중간점
cen <- c(mean(df$lon),mean(df$lat))
map<- get_googlemap(center = cen,
                    maptype = "roadmap",
                    zoom = 13,
                    markers = gc)
ggmap(map)+
  geom_line(data = gc,
            aes(x=lon,
                y=lat,
                color="red"))

cendf<-data.frame(lon=mean(df$lon),lat=mean(df$lat))
result<-ggmap(map)+
  geom_line(data = gc,
            aes(x=lon,
                y=lat,
                color="red"))+
  geom_point(data=cendf,
             aes(x=lon,
                 y=lat))

ggplotly(result)

####################### 확대, 값 확인

#### 시계열 그래프

#### 시간에 따른 선그래프는 단순 확대만으로는 사용이 힘들어요
#### 특정 구간에 대한 자세한 사항을 보기 위해서 다른 package를 이용

install.packages("dygraphs")
library(dygraphs)

# 예제로 사용할 data set은 economics

# 시계열 그래프는 데이터를  xts라는 형시으로 변환시켜줘야 해요!

# 시간에 따른 개인 저축률 변환 추이를 선 그래프로 그릴꺼에요

df <- economics
ggplot(data=df,
       aes(x=date,
           y=psavert))+
  geom_line()

library(xts)
save_rate<- xts(df$psavert,
                order.by=df$date)
tail(save_rate)
dygraph(save_rate)%>%
  dyRangeSelector()

unemp_rate<- xts(df$unemploy/1000,
                order.by=df$date)
unemp_save <- cbind(save_rate,unemp_rate)
head(unemp_save)

dygraph(unemp_save)%>%
  dyRangeSelector()
