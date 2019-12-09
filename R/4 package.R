# package #

# R은 처음 설치할 때 base package가 같이 설치됨
# 추가적인기능을 잉ㅇ하기 위해 외부 package를찾아 설치함


# 그래프용 package "ggplot2" 설치하기

  install.packages("ggplot2")
# 설치된 pakage를 메모리에 load해야 사용할수 있다. 둘 중 하나를 이용해서 패키지를 메모리에 로드할 것
library(ggplot2)
require(ggplot2) # 둘 중 하나를 사용할 것


#연습: 간단한빈도를 나타내는 막대그래프그리기 위해 Vector 하나 만들어보자
  
  var1=c("a","b","c","a","b","a")
  # package안의 함수를이용해빈드 그래프를 그려보자
  qplot(var1)#빠르게 그려주는 차트

remove.packages("ggplot2")

.libPaths()
.libPaths("C:/r_lecture/lib")

help(qplot)

example(qplot)

#workingdirectory

getwd() #<-워킹디렉토리위치를 알아내기
setwd("c:/R_lecture/") #<- 워킹디렉토리 위치 지정하기
