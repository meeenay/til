# reshap2 package
# 데이터의 형태를 바꿀 수 있어요!
# 가로로 되어 있는 데이터를 세로로 바꿀 수 있어요!
# 컬럼으로 저장되어 있는 데이터를 row형태로 
# row 형태의 데이터를 column 형태로 전환

# 이해를 돕기 위해 2개의 sample file을 이용하기
# melt_mpg.csv,  sample_mpg.csv
sample_mpg <- read.csv(file = "C:/R_lecture/data/11.05/sample_mpg.csv",
                       sep = ",",
                       header = T,
                       fileEncoding = "UTF-8")
sample_mpg

melt_sample_mpg <- read.csv(file = "C:/R_lecture/data/11.05/melt_mpg.csv",
                            sep = ",",
                            header = T,
                            fileEncoding = "UTF-8")
melt_sample_mpg
View(melt_sample_mpg)

# 두 개의 data frame에 대해서 평균 도시 연비
library(dplyr)
library(ggplot2)
library(stringr)

mean(sample_mpg$cty)     # 18.25
filter(melt_sample_mpg,
       variable=="cty")%>%
  summarise(melt=mean(value))    # 18.25

# 두 개의 data frame에 대해서 평균 연비를 구해서 
# 표시(평균 연비 = 도시 연비와 고속도로 연비의 평균으로 계산)

sample_mpg %>%
  mutate(avg_rate =(cty+hwy)/2)

melt_sample_mpg # 처리하기 어려움 이때 reshape()사용

############ reshape2 package느 수집한 데이터를 
############ 분석하기 편한 형태로 가공할 때 사용하는 
############ 대표적인 package

### 2개의 함수만 잘 알아두면 되요!!
### 1. melt() 

# column을 row 형태로 바꾸어서 가롤로 긴 데이터를
# 세로로 길게 전환하는 함수
# melt()의 기본동작은 numeric을 포함하고 있는 
# 모든 column을 row로 변환해요!

# 간단한 예를 통해서 melt()의 동작방식을 알아보아요!
install.packages("reshape2")
library(reshape2)

# 기본적으로 R이 내장하고 있는 data set
help(airquality)
ls(airquality)
#"Day"     "Month"   "Ozone"   "Solar.R" "Temp"   "Wind"
# 날짜      월        오존량    태양열    온도   바람세기

head(airquality)
str(airquality)

# 기본 data set을 다룰 때는 다른 변수에 백업해 두는 것이 좋다. 잘못하면 다시 설치해야 한다.
df<- airquality     # 건들지 말아요
df                  # 153행, 6열
melt(df)            # 918행, 2열
melt(df, na.rm = T) # na.rm: 결측치를 제거하라
nrow(melt(df, na.rm = T))# 결측치 제거후  :874행
melt(df,id.vars = "Month") # 153*5=765행
                           # id.vars :녹이지 않을 column설정
melt(df,id.vars = c("Month","Day")) # 복수 설정도 가능
melt(df,id.vars = c("Month","Day"),
     measure.vars = "Ozone")      # measure.vars :녹일 column 설정
melt_df<-melt(df,id.vars = c("Month","Day"),
          measure.vars = "Ozone",
          variable.name = "Item",
          value.name = "Item_value")
# variable.name: 녹인 변수 이름 변경
# value.name : 녹인 변수의 값의 이름 변경

# dcast() : data frame에 대한 cast 작업
# row로 되어 잇는 데이터를 column 형태로 전환

melt_df
dcast(melt_df,
      formula = Month + Day ~ ...)
# formula = Month + Day :기존에 있는 값
#                       ~ ... :melt된 값

# 기존에 있는 id를 잘 안써주면 이상한 결과 초래
dcast(melt_df,
      formula = Month  ~ ...)

# 집계함수 적용가능능
dcast(melt_df,
      formula = Month  ~ Item,
      fun=mean,
      na.rm=T)

## 처음에 받은 csv파일의 내용을 원산복귀시켜보기
melt_sample_mpg
dcast(melt_sample_mpg,
      formula = manufacturer+
        model + class + 
        trans + year ~ variable,
      value.var = "value")
## 제공된 파일은 이용한 melt 형식의 data frame은 원상복귀 될 수 없음! (id들이 중복됨)
## melt()된 데이터를 생성해보기!
## mpg를 가지고 melt data set을 생성해 보기

df <-mpg
head(df)
audi_df <- df%>%
  filter(manufacturer=="audi",
         model=="a4")
melt_audi_df<-melt(audi_df,
                   id.vars = 
                     c("manufacturer","model",
                       "year","cyl","trans"),
                   measure.vars = 
                     c("displ","cty","hwy"))
melt_audi_df

## 내용을 원산복귀시켜보기
dcast(melt_audi_df,
      formula = manufacturer+
        model + cyl + 
        trans + year ~ ...,
      value.var = "value")a


