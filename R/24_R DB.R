getwd()
setwd("C:/r_lecture")
.libPaths("C:/r_lecture/lib")
# R에서 Database에 연결해 보아요!
# MySQL에 연결해서 도서DB의 데이터를 가져올꺼에요!!

# 1. MySQL를 기동

# 2. R에서 DBMS에 접근하려면 몇개의 package와 
둘을 

# 사용하려는 DB가 Java 언어를 이용!
# Java가 설치가 되어있어야 해요!
# JAVA_HOME 환경변수도 잡아줘야 해요!

install.packages("rJava")
# R언어에서 Java언어를 사용하기 위한 package
library(rJava)
install.packages("RJDBC")
# R언어에서 JDBC라는 기능을 이용하기 위한 package
library(RJDBC)
install.packages("DBI")
# database를 사용하기 위한 package
library(DBI)

## 필요한 package와 로딩이 끝나고

# driver가 필요
# Java언어가 Database에 접속하고 
# 사용하기 위한 기능이 들어있는 library
# 사용하는 데이터베이스마다 설정방법이 달라요

# MySQL Driver 설정
# Java가 Database를 접속, 이용하기 위한 설정
# mysql-connector-java-5.1.48-bin.jar 다운로드

#경로설정
drv = JDBC(driverClass = "com.mysql.jdbc.Driver",
           classPath = "C:/r_lecture/data/mysql-connector-java-5.1.48-bin.jar")

# R언어엣 Database 연결

conn <- dbConnect(drv,
                  "jdbc:mysql://localhost:3306/library",
                  "data",     #id
                  "data")     #passwd

# Query 실행 (SQL : 데이터베이스를 제어하기 위한 언어)

sql = "select * from book"
df<-dbGetQuery(conn,sql)
head(df)

install.packages("dplyr")
library(dplyr)

newdf<-df %>%
  filter(bprice>55000)%>%
  select(btitle)

View(newdf)


#---------------------------------------

sql = "select btitle, bprice from book"
df<-dbGetQuery(conn,sql)
head(df)

install.packages("dplyr")
library(dplyr)
newdf <- df %>%
  filter(bprice>30000)%>%
  select(btitle)

View(newdf)


#################################

# R의 기본 & EDA (끝!!)

# ===>  Python
# ===> data type & data structure & 로직
# ===> Numpy & Pandas를 이용한 EDA
# ===> 통계 개념, Python에서 처리 , R에서 처리
# ===> 통계적 데이터 분석
# ===> Tensorflow를 이용한 machine learning > AI
# ===> Deep Learning(CNN)
# ===> R에서는 어떻게 하는지
