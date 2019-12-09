getwd()
setwd("C:/r_lecture")
.libPaths("C:/r_lecture/lib")

# <3주차 학습계획>
# 데이터 조작 (월)
# 데이터 정제 (화)
# 시각화에 대한 내용 (ggplot2) (수목금)

####################################################
######## 데이터 조작 복습 및 확장#################
# mpg data set 을 이용해 데이터 조작, 정제에 대한 내용을 학습해보자
# mpg data set은 ggplot2 안에 존재
# ggplot2는 그림그려주는 대표적인 패키지

install.packages("ggplot2")
library(ggplot2)

mpg
str(mpg)
class(mpg)

# mpg는 table data frame 형태 이고
# console 크기에 맞추어 data frame을 출력

df <- as.data.frame(mpg) ;df
class(df)

#data frame의 column명을 알아보기
ls(df)
names(df)

# mpg에 대한 document를 확인해서 column의 의미를 먼저 파악하기

help(mpg)

head(df,3) # 
View(df)  #View 창을 통해 데이터를 확인
dim(df) #차원을 알려줌. df에 적용할 경우 c와 r의 갯수를 알려줌
nrow(df)
ncol(df)
length(df) # 주의 : data frame에서는 열의 개수
           # vector 원소 개수 
           # matrix  원소 개수
str(df) # 종합정보: 자료구조, 행개수, 열개수,
        # 컬럼명, 데이터 타입...
summary(df) # 가장 기본적인 통계 데이터 추출
rev(df)     # 거꾸로 출력



################################################
## 데이터 조작(dplyr: 디플라이알)
## data frame을 조작할 때 가장 많이 사용하는 패키지
## 속도에 강점: C++로 구현되어 있음
## dplyr이 제공하는 여러 함수를 이용해
## 우리가 원하는 데이터를 추출할 수 있음

library(dplyr)

# 1. tbl_df()
df
df <- tbl_df(df)        # table data fame
df <- as.data.frame(df) # dataframe


# 2. remane() # column의 이름을 변경할 수 있어요
# raw data를 이용할 경우 column명이 없을 때 
# column명을 새로 명시에서 사용해야 한다
# 컬럼명에 대소문자가 같이 있는 경우 
# 모두 소문자, 대문자로 변경해서 사용하면 편하다

# df의 컬럼명을, 모두 소문자로 변경

names(df) <- toupper(names(df))
names(df) <- tolower(names(df))
df

# rename은 개별적으로 지정해줘야함
rename(df,
       Class = class) # 이렇게만 사용하면 변화가 없음                       # rename은 기존df 변경X므로
                      # 따라서 아래와 같이 처리
new_df <- rename(df,
                 Class = class)


# 3. 조건을 만족하는 행을 추출해주는 함수
# 행추출 -> filter,  열 추출 -> select
# filter(data frame, 조건1, 조건2, 조건3,...)
# mpg dataset에서 


###################연습문제 #####################
### 2008년도에 생산된 차량이 몇 개 있는지 추출##

df<- as.data.frame(mpg)
nrow(filter(mpg, year == 2008))



# 모든 차량에 대해 평균 도시연비보다 도시 연비가 높은 차량의 model 명을 출력하시오


df<-filter(mpg,cty>mean(
                cty,na.rm=T)) %>% # Na가 있으면 삭제
      select(model)

df<-unique(df)
nrow(df)

factor(df)





## 선생님 솔루션
avg_cty <- mean(df$cty, na.rm=T); avg_cty
filter(df,
       cty > avg_cty)$model # filter가 df로 출력되므로 그 중 model



#고속도로 연비가 상위 75% 이상인 차량을 제조하는
#제조사는 몇개인지 추출하시오

hwy_df <- as.data.frame(mpg)
hwy_manu<-filter(hwy_df,hwy>=quantile(mpg$hwy)[4]
                 )$manufacturer

length(unique(hwy_manu))

# 선생님 솔루션

length(unique(filter(hwy_df,hwy>=summary(df$hwy)[5])$manufacturer))

#####오토 차량중 배기량이 2500cc 이상인 차량 수는 몇 개인가? displ

df <- as.data.frame(mpg)
View(df)

# 1) grepl 사용
nrow(filter(df, grepl("(?i)auto", trans)==TRUE, displ>=2.5))

# 2) str_detect 사용
library(stringr)
nrow(filter(df, str_detect(trans,"auto")==TRUE, displ>=2.5))

# 3) subset
nrow(filter(
  df,
  (str_sub(df$trans,1,4)=="auto")==T, 
  displ>=2.5))



### 4. arrange(): 정렬하는 함수
# arrange(data frame, column1) 
# 기본정렬방식 오름차순
# arrange(data frame, column1, desc(column2)
#    column1을 이용해 정렬하되, 이 기준이 동률인
#    case는 column2를 이용해 내림차순 정렬

# 모든 차량에 대해 평균 도시 연비보다 도시연비가 높은 차량의 medel 명을 출력하시오.
# 단, 모델명을 오름차순으로 정렬하시오

df_mpg <- as.data.frame(mpg)
df<-filter(df_mpg,cty>mean(
  cty,na.rm=T)) %>% 
  select(model)

df <- unique(df)
arrange(df,model)

# 1) without chaining
unique(filter(df,
              cty > avg_dty)$model)

# 2) with chaining --> better!
    # chaining의 의미는 앞의 자료를 넘기라는 의미 따라서 아래와 같이 df를 넘겨준 다음에는 filter안에df를 다시 써줄 필요가 없음.

df_mpg %>% filter(
           cty > mean(cty,na.rm=T)) %>% 
           select(model) %>%
           unique() %>% arrange(model)


# 5. select(): data frame에서 원하는 column만
#    추출하는 함수
# select(data frame, column2, column2)





# 6. 새로운 column을 생성하려면 어떻게 해야 
# 하나?

# 도시연비와 고속도로 연비를 합쳐서 평균 연비 
# column을 만들어 보자

df$mean_rate = (df$cty + df$hwy) /2

df %>% mutate(meanrate = (cty+hwy)/2) ## ?? 함수사용불가?




# 7. 통계량을 구해서 새로운 컬럼으로 생성하는 
#   함수 : summarise()  <> summary
# model 명이 a4이고 배기량이 2000CC 이상인 
# 차들에 대해 평균 연비를 계산하세요!

#1) 내 솔루션
df %>% filter(str_detect(model,"a4")==T,
              displ>=2) %>%
              summarise(mean(c(cty,hwy)))


# 2) 선생님 without summarise
result <- df %>% 
          filter(model =="a4",
                 displ >= 2.0) %>%
          mutate(avg_rate = (cty + hwy)/2) %>%
          select(avg_rate)

mean(result$avg_rate) # mean 안에 df가 들어가면 오류남


# 3) 선생님 with summarise 
# summarise 특징은, 통계값이 하나만 도출된다는 것
# 여러개의 레코드를 하나의 레코드로 축약하여, 해당 칼럼들에 row가 하나로 줄어든다는 의미

df %>% filter(model =="a4",
              displ>=2.0) %>%
      summarise(avg_rate = mean(c(cty,hwy)))

df %>% filter(model =="a4",
              displ>=2.0) %>%
  summarise(avg_rate = mean(c(cty,hwy)),
            hahaha = max(cty))

                