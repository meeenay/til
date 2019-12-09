# 사용하는 데이터는 
# 한국 복지 패널 데이터

# 한국 보건 사회연구원 => 2006년부터 10년간
# 7000여 가구에 대한경제활동, 생활 실태, 복지 욕구 등등등

# 파일을 복사해야되요

# 제공받은 데이터 파일은 spss 파일입니다!
# 새로운 패키지로 불러들일수 있습니다.
install.packages("foreign")
install.packages("dplyr")
install.packages("ggplot2")
library(foreign)
library(stringr)
library(xlsx)
library(dplyr)
library(ggplot2)

# 사용할 raw data를 불러와요!
raw_data_file <- "C:/r_lecture/data/한국복지패널데이터/Koweps_hpc10_2015_beta1.sav"

raw_welfare <- read.spss(raw_data_file,
                         to.data.frame = T)

# 원보 raw파일은 보존해 놓아요!!!
welfare<-raw_welfare
head(welfare)
str(welfare)


# 데이터 분석에 필요한 컬럼은 컬럼명을 변경해요!

welfare <- rename(welfare,
                  gender=h10_g3, # 성별
                  birth=h10_g4,  # 출생년도
                  marriage=h10_g10, # 결혼 상태
                  religion=h10_g11, # 종교 유무
                  code_job=h10_eco9,# 직종 코드
                  income=p1002_8aq1,# 월 평균 임금
                  code_region=h10_reg7) # 지역코드

###################################### 준비 완료

# 1. 성별에 따른 월급 차이

table(welfare$gender) # 이상치가 있는지 확인

# 1은 male로 변경하고 2는 female로 변경

welfare$gender = ifelse(welfare$gender==1,
                        "male",
                        "female")

table(welfare$gender)

class(welfare$income) # numeric: 월급에 대한 데이터 타입

summary(welfare$income) # 기본 통계값 확인

qplot(welfare$income)+
  xlim(0,1000)            # 확인 용도
# 0~250만원 사이에 가장 많은 사람들이 분포하고 있네요!!

# 월급에 대한 이상치 부터 처리
# 월급이 0이거나 9999(모름,무응답) 처리

welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)

# 결측치 갯수 확인
table(is.na(welfare$income))

#### 분석을 하기 위한 준비가 끝나요!!
# 결과를 받을 새로운 데이터 프레임
gender_income <- welfare%>%
  filter(!is.na(income))%>%    # 결측치 제거
  group_by(gender)%>%          # 그룹ing
  summarise(mean_income = mean(income)) # 평균값

gender_income=as.data.frame(gender_income)

gender_income

# 통계자료에 대한 빈도는 col로 파악하는 것이 좋다.
# bar는 raw data에 대한 빈도 파악

ggplot(data=gender_income, 
       aes(x=gender,
           y=mean_income))+
  geom_col(width = 0.5)+     
  labs(x="성별",
       y="평균월급",
       title="성별에 따른 평균 월급",
       subtitle="남성이 여성보다 두배가량 많이 벌어요",
       caption="Example 1 Fig.")



###################self##############################
welfare %>%
  mutate(gender = ifelse(gender==1,"male","female"))%>%
  filter(income>0&income!=9999)%>%
  group_by(gender)%>%
  summarise(avg_Income = mean(income,na.rm = T))

  
  
  ##############################################

# 사용할 데이터
welfare

# 2. 나이와 월급의 관계 파악
# 몇살 때 월급을 가장 맣이 받을까?
# 나이에 따른 월급을 선그래프로 표현

# 월급의 전처리 여부: yes
# 나이의 전처리 여부 : no

## 나이 전처리
# 출생년도 사용 , 구조 파악
summary(welfare$birth)

## 결측치나 무응답 없음

age_income<-welfare%>%
          mutate(age=2015-birth+1)%>%
          filter(income>0&income!=9999&!is.na(income))%>%
          group_by(age)%>%
          summarise(mean_income=mean(income,na.rm = T))%>%
          arrange(desc(mean_income))

ggplot(data=age_income,
       aes(x=age,
           y=mean_income)) +
  geom_line()+
  labs(title = "나이에 따른 평균월급",
       subtitle="53살에 318.6777 만원을 받아요")

# 2015년도를 기준으로 53살에 318.6777 만원을 받아요

#########쌤이랑 풀이##########
class(welfare$birth)    # 출생년도(숫자)
summary(welfare$birth)  

qplot(welfare$birth)    # 빈도를 알 수 있어요

# 나이에 대해 결측치가 있나 확인
table(is.na(welfare$birth))   #결측치가 없네요!

# 이상치(9999)도 check해야 해요
welfare$birth = ifelse(welfare$birth==9999,
                       NA,
                       welfare$birth) # 이상치도 없어요

# 나이에 대한 column이 존재하지 않기 때문에 column을 생성해야 해요!
welfare<- welfare%>%
  mutate(age=2015-birth+1)
summary(welfare$age)
qplot(welfare$age)

age_income<-welfare%>%
  filter(!is.na(income))%>%
  group_by(age)%>%
  summarise(mean_income=mean(income))

head(age_income)

age_income = as.data.frame(age_income)

# 가장 월급을 많이 받는 나이는?
age_income%>% arrange(desc(mean_income))

# 나이에 따른 월급을 선그래프로 표현
ggplot(data=age_income,
       aes(x=age,
           y=mean_income)) +
  geom_line()+
  labs(title = "나이에 따른 평균월급",
       subtitle="53살에 318.6777 만원을 받아요")



# 3.연령대에 다른 월급 차이
# 30대 미만 : 초년(youn)
# 30~59세: 중년(middle)
# 60세 이상: 노년(old)

# 위의 범주로 연령대에 다른 월급 차이 분석

# 새로운 범주를 위한 column 생성: generation

generationdf<-welfare%>% mutate(age=2015-birth+1) %>% mutate(generation=age)

# 방법 1
for(i in 1:length(generationdf$generation)){
  if(generationdf$generation[i]>=1&generationdf$generation[i]<30){
    generationdf$generation[i]="young"s
  }else if(generationdf$generation[i]>29&generationdf$generation[i]<60){
    generationdf$generation[i]="middle"
  }else if(generationdf$generation[i]>59){
    generationdf$generation[i]="old"
  }
}

# 방법2
for(i in 1:length(generationdf$generation)){
  if(generationdf$generation[i]%in%c(1:29)){
    generationdf$generation[i]="young"
  }else if(generationdf$generation[i]%in%c(30:59)){
    generationdf$generation[i]="middle"
  }else {
    generationdf$generation[i]="old"
  }
}

# 빈도 확인
table(generationdf$generation)

# 그래프 그리기
generationdf<-generationdf%>%
  group_by(generation)%>%
  summarise(mean_income=mean(income,na.rm = T))

View(generationdf)

ggplot(generationdf,
       aes(x=generation,
           y=mean_income))+
  geom_col()


###########선생님 풀이##############
# 위의 범주로 연령대에 따른 월급 차이 분석
# 위에서 했던 나이에 따른 월급 차이와 크게 다른점이 없어요...

# 연령대라는 새로운 column을 추가해야 해요!
welfare<-welfare%>%
  mutate(age_group =ifelse(age<30,"young",
                           ifelse(age<60,
                                  "middle",
                                  "old")))

table(welfare$age_group)

age_group_income<-welfare%>%
  filter(!is.na(income))%>%
  group_by(age_group)%>%
  summarise(mean_income=mean(income))

age_group_income<-as.data.frame(age_group_income)

ggplot(age_group_income,
       aes(x=age_group,
           y=mean_income))+
  geom_col(width = 0.5)

# gglot은 막대 그래프를 그릴때 기본적으로 x축 데이터에 대해 알파벳 오름차순으로 정렬해서 출력

# 막대그래프 크기로 순서를 바꾸려면

# 월급이 큰순서
ggplot(age_group_income,
       aes(x=reorder(age_group,-mean_income),
           y=mean_income))+
  geom_col(width = 0.5)

# 월급이 작은 순서
ggplot(age_group_income,
       aes(x=reorder(age_group,mean_income),
           y=mean_income))+
  geom_col(width = 0.5)

# 나이별로 순서 재좆정
# 막대그래프의 x 축 순서를 내가 원하는 순서로 바꾸려면 어떻게 해야 하나요??

ggplot(age_group_income,
       aes(x=age_group,
           y=mean_income))+
  geom_col(width = 0.5)+
  scale_x_discrete(limits=c("young","middle","old"))
# 이산형 데이터에 대해서 적용가능
# 순서를 vector 형태로 부여한다.


#################################################

# 4. 연련대 및 성별의 월급 차이를 알아보아요
welfare<-welfare%>%
  mutate(age_group =ifelse(age<30,"young",
                           ifelse(age<60,
                                  "middle",
                                  "old")))

gender_age_income<-welfare%>%
  mutate(age_gender = age_group)%>%
  mutate(age_gender = ifelse(gender=="female",
                             str_c(age_gender,"/",gender),
                             str_c(age_gender,"/",gender)))%>%
  group_by(age_gender)%>%
  summarise(mean_income=mean(income,na.rm = T))

ggplot(data=gender_age_income,
       aes(x=age_gender,
           y=mean_income))+
  geom_col()


############선생님 풀이###############
gender_age_income <- welfare%>%
  filter(!is.na(income))%>%
  group_by(age_group,gender)%>%
  summarise(mean_income=mean(income,na.rm = T))

gender_age_income<- as.data.frame(gender_age_income)
gender_age_income

# 누적 차트틀 표현해야 될 듯 해요!!
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income))+
  geom_col(aes(fill=gender))


ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender))+
  geom_col()

# 막대그래프의 축 순서를 내가 원하는 순서로 바꾸려면 어떻게 해야하나요?

ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender))+
  geom_col(position = "dodge")+
  scale_x_discrete(limits=c("young","middle","old"))


#####################################################

# 5. 나이 및 성별에 따른 월급 차이 분석
gender_age <- welfare%>%
  filter(!is.na(income))%>%
  group_by(age,gender)%>%
  summarise(mean_income=mean(income,na.rm = T))

gender_age<- as.data.frame(gender_age)
gender_age

ggplot(data=gender_age,
       aes(x=age,
           y=mean_income,
           color=gender))+
  geom_line()


########### 선생님 풀이#######
gender_age<-welfare%>%
  filter(!is.na(income))%>%
  group_by(age,gender)%>%
  summarise(mean_income=mean(income,na.rm = T))

gender_age<- as.data.frame(gender_age)
gender_age


ggplot(data=gender_age,
       aes(x=age,
           y=mean_income,
           color=gender))+
  geom_line(size=1)


##################################################

names(welfare)

# 6. 직업별 월급 차이를 분석
# 가장 월급을 많이 받는 직업은?
# 가장 월급을 적게 받는 직업은?
job_code <-read.xlsx(file="C:/r_lecture/data/한국복지패널데이터/Koweps_Codebook.xlsx",2,encoding="UTF-8")

job_code <- as.data.frame(job_code)

df<-left_join(welfare,job_code)

View(df)
df$job
df$income

df<-df%>%
  group_by(job)%>%
  summarise(mean_income=mean(income,na.rm = T))%>%
  filter(!is.nan(mean_income))%>%
  summarise(maxIncome=max(mean_income),
            minIncome=min(mean_income)) %>%
  select(job, maxIncome,minIncome)
  
View(df)

df<-rbind(head(df,1),tail(df,1))
ggplot(df,
       aes(x=job,
           y=mean_income))+
  geom_col(width = 0.5)+
  coord_flip()


##########강사님 ####

raw_code <- read.xlsx(file = "C:/r_lecture/data/한국복지패널데이터/Koweps_Codebook.xlsx",
                      2,
                      encoding = "UTF-8")
raw_code
code<-raw_code
head(code)
head(welfare)
welfare$code_job
welfare_job=full_join(welfare,code)
welfare_job$job
View(welfare_job)

gender_job_income <- welfare_job %>% 
  filter(!is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

gender_job_income = as.data.frame(gender_job_income)
gender_job_income

ggplot(data=gender_job_income,
       aes(x=job,
           y=mean_income)) +
  geom_col() +
  coord_flip()

arrange(gender_job_income, mean_income)[1:5,]
arrange(gender_job_income, desc(mean_income))[1:5,]

###진슈 ###
install.packages("readxl")
library(readxl)

jobdf <- read_excel("C:/r_lecture/data/한국복지패널데이터/Koweps_Codebook.xlsx",sheet = 2)
jobdf <- as.data.frame(jobdf)
jobdf
exp <- left_join(welfare,jobdf)
exp$job
jobinc <-
  exp %>% filter(!is.na(job))%>% group_by(job)%>% summarise(mean_income = mean(income,na.rm = T))
jobinc <- as.data.frame(jobinc)
## 제일 높은 직업과 낮은직업 뽑기
exp2 <- rbind(head(jobinc %>% arrange(mean_income),1),head(jobinc %>% arrange(desc(mean_income)),1))
exp2




####################################################
# 7. 종교 유무에 다른 이혼률
# 종교가 있는 사람이 이혼을 덜 할까?

df<- welfare%>%
  mutate(divorce=ifelse(marriage %in% c(1,2,3,4),
                        marriage,NA),
         religion=ifelse(religion==1,"Yes","No"))%>%
  filter(!is.na(divorce))%>%
  group_by(religion,divorce)%>%
  summarise(percent=n())
head(df,8)
df<-df%>%
  mutate(total=ifelse(religion=="No",
                      summarise(group_by(df,religion),n=sum(percent))[1,2],
                      summarise(group_by(df,religion),n=sum(percent))[2,2]))%>%
  filter(divorce==3)%>%
  mutate(percent=percent/total[[1]]*100)%>%
  select(religion,percent)

df

ggplot(df,
       aes(x=religion,
           y=percent))+
  geom_col()+
  labs(title="종교 유무에 따른 이혼률")

###11.08######
#################선생님 풀이########################

# 종교 유무에 다른 이혼률
# 종교가 있는 사람이 이혼을 덜 할까?

# 종교가 없는 사람의 이혼율: 7.0
# 종교가 있는 사람의 이혼율: 5.6

# 이혼 여부를 나타내는 컬럼을 만들어야 할거 같아요!1
# ex) group_marriage
# 만약 1,2,4이면  group_marriage => marriage
# 만약 3이면 group_marriage => divorce

# 어려울 경우 최종 결과물을 예측하고 결과물을 얻어내기 위해 풀어나가는 방법이 있다.

# 1. 새로운 column을 만들어 보아요!
# 새로운 column marriage를 (1:4)범위로 만든다.
welfare <- welfare%>%
mutate(group_marriage=
         ifelse(marriage %in% c(1,2,4),
                "marriage",
                ifelse(marriage == 3,
                       "divorce",NA)))

table(welfare$group_marriage)

religion_divorce <-welfare%>%
  filter(!is.na(group_marriage))%>%
  group_by(religion,group_marriage)%>%
  summarise(n=n())%>%
  # 상위 그룹에 대한 합계를 구해준다.
  mutate(totaln=sum(n))%>%
  mutate(pct=round(n/totaln*100,1))

religion_divorce


################################################
# EDA ( Exploratory Data Analysis )
# => 탐색적 데이터 분석


