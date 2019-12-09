################# R Graph ##########################
#
# 숫자나 문자로 표현하는 것 보다는 
# 그림(그래프)으로 표현하면 변수의 관계 
# 데이터의 경향을 좀 더 쉽게 파악할 수 있다

# 산점도 (Scatter) - 변수간의 관계를 파악
# 막대그래프  - 빈도수 계산 또는 집단간 비교
# 선 그래프 - 시계열 자료 표현
# 박스 그래프 - 데이터의 분포 확인


##########################################################
###########################################################
# 1. 산점도
# ggplot2는 3단계로 그래프를 그린다
# 1) 축을 정한다. (배경을 설정)  : x축과 Y축 기준
# 2) 그래프를 추가한다
# 3. 축 범위, 배경 설정. 

install.packages("ggplot2")
library(ggplot2)

mpg

  #테이블 데이터 -> 데이터 프레임
  df_mpg <- as.data.frame(mpg)
  df_mpg

  # 1) 배경설정
  #   data설정: 그래프를 그리는데 필요한 데이터
  #   aes (x =, y=)
  
  # 배기량과 고속도로 연비의 관계 확인
  ggplot(data=df_mpg, 
         aes( x= displ, 
              y=hwy ))
  
  # 2) 그래프 추가
  # 우리가 원하는 그래프를 그릴 수 있다 
  # ggplot2 는 chaining기호가 + 임
  ggplot(data=df_mpg, 
         aes( x= displ, 
              y=hwy )) + 
    geom_point()   # 산점도를 그려요
  
  # 3) 설정을 추가할 수 있다
  # x와 y의 보고싶은 영역만 추가
  
  ggplot(data=df_mpg, 
         aes( x= displ, 
              y=hwy )) + 
    geom_point()   +
    xlim(3,5) + #x의 limit을 3~5
    ylim(20,30)
  
  # 데코 옵션 : 점의 크기, 색상 조절
   ggplot(data=df_mpg, 
         aes( x= displ, 
              y=hwy )) + 
    geom_point(size = 3, color="red")+ # 색상과 사이즈 부여
    xlim(3,5) + 
    ylim(20,30)
   
   
 # plot 비우기
   plot.new () 
 
   
   
   
  
####################################################   
####################################################
# 2. 막대그래프 
# 집단간의 비교를 할 때 사용
   
# 구동방식(drv) : f(전륜), r(후륜), 4(4륜) -> 범주형

# 구동방식별 고속도로 연비 차이(평균)을 알아보자
install.packages("dplyr")
library(dplyr)

# 1)막대그래프를 그리기 위해 평균 데이터 준비
result <- 
     df_mpg %>% 
     group_by(drv) %>%
     summarise(avg_hwy=mean(hwy)) ;

result <- as.data.frame(result)
str(result)

# 2) 막대그래프 그리기
ggplot(data = result,
        aes(x=drv, y=avg_hwy)) +
        geom_col()

# 3) 막대그래프 정렬 순서를 바꾸기
#   막대그래프 길이에 따른 재배치 
    ggplot(data = result,
         aes(x=reorder(drv, avg_hwy), # y값 크기에 따라
                                      # x리오더
             y=avg_hwy)) +
      geom_col()

    
    ggplot(data = result,
           aes(x=reorder(drv, -avg_hwy), # 내림차순
               y=avg_hwy)) +
      geom_col()

######################################################
# 2-2. 빈도 막대그래프
# 사용하는 함수/ 사용방법 알아두기
# 사용하는 함수는 geom_bar()
# raw data frame을 직접 이용해서 처리
    
ggplot(data=df_mpg,
         aes(x=drv)) +
    geom_bar()

    
#########################################################
# 2-3 누적 빈도 그래프
# 4륜 구동 내에서 배기량의 종류를 구분해 
# 누적빈도 그래프 그리기

ggplot(data=df_mpg,
       aes(x=drv)) +
  geom_bar(aes(fill=factor(cyl)))
    
# trans에 따라
ggplot(data=df_mpg,
       aes(x=drv)) +
  geom_bar(aes(fill=factor(trans)))

# class에 따라
ggplot(data=df_mpg,
       aes(x=drv)) +
  geom_bar(aes(fill=factor(class)))


######################################################
# 2-4 히스토그램 : 구간당 분포 표현
# 연속형변수에 해당

# 아래와같이 범주형변수인 drv를 사용할 경우 graph 산출X
  ggplot(data=df_mpg,
         aes(x=drv)) +
    geom_histogram(drv)

# 연속형 변수인 연비로 그려보기
# 기본적으로 30개 영역으로 나눠 표시 해준다
  ggplot(data=df_mpg,
         aes(x=hwy)) +
    geom_histogram()
  
  
  
######################################################
######################################################
## 선 그래프 (시계열 자료)

# 일반적으로 환율, 주식, 경제동향을 표시
# mpg는 시간에 대한 데이터가 없으므로 
# 대신 economics data set 을 이용
# (ggplot2 패키지 안에 포함됨)
  
economics   # table data frame

# 1) 변수 확인

help(economics)
tail(economics)  # 1967~2015.4 까지 경제지표 data
ls(economics)  
  # "date"     "pce"(개인소비지출 10억단위) 
  # "pop" (인구수,천)    "psavert" (개인저축율) 
  # "uempmed"(실업기간.주 단위 중위수)
  # "unemploy"(실업인구수)


# 2) 시간에 따른 실업률 추세 알아보기
ggplot(data=economics,
       aes(x=date,
           y=unemploy)) +
       geom_line()

# scatter도 함께 찍을 수 있다
ggplot(data=economics,
       aes(x=date,
           y=unemploy)) +
  geom_point(color ="red") +
  geom_line()

#####################################################
#####################################################
# box 그래프 ( 데이터의 분포 )


df <- as.data.frame(mpg)
head(df)

# 구동 방식별 hwy(고속도로 연비)
# 상자 그림을 그려보자!

ggplot(data=df,
       aes(x=drv,
           y=hwy))+
  geom_boxplot()


######################################################
# 이렇게 ggplot2를 이용해 
# 4가지 종류의 그래프를 그릴 수 있다.
# 여기에 추가적인 객체를 포함하여 
# 그래프를 좀 더 이해하기 쉬운 형태로 만들어 보자
######################################################

# mpg: 연비에 대한 data set
# economics : 월별 경제 지표에 대한 data set

# 날짜별 개인저출축률에 대한 선 그래프를 그려보자

ls(economics)

ggplot(economics,
       aes(x=date,
           y=psavert)) +
  geom_line()


# 위에서 구한 그래프에 경향을 보여주는 그래프를 그릴 것
# 회귀분석이긴 하나, 지금은 숫자를 구해서 그리기
# 기울기와 절편을 직접 구하자
# 선을 구하면 추론이 가능해짐

ggplot(economics,
       aes(x=date,
           y=psavert)) +
  geom_line() +
  geom_abline(intercept = 12.1,
              slope = -0.0003444)


# 수평선 그리기 (전체 평균을 나타내는)
ggplot(economics,
       aes(x=date,
           y=psavert)) +
  geom_line() +
  geom_hline(yintercept = #y절편인지 x절편인지 명시
               mean(economics$psavert)) 


# 수직선 그리기 (psavert가 최저인 지점 )

lowdate<- filter(economics,
       psavert==min(psavert)) %>% select(date)

lowdate <- as.data.frame(lowdate);
result <-lowdate$date

ggplot(economics,
       aes(x=date,
           y=psavert)) +
  geom_line() +
  geom_vline(xintercept = result)


#  만약 직접 날짜를 입력해서 수직선을 표현하려면

ggplot(economics,
       aes(x=date,
           y=psavert)) +
  geom_line() +
  geom_vline(xintercept = "2005-05-01") # 오작동

# 현재 날짜 형태의 문자열로 되어있기 때문임
# 따라서 날짜형식으로 변환 해야함

ggplot(economics,
       aes(x=date,
           y=psavert)) +
  geom_line() +
  geom_vline(xintercept = as.Date("2005-05-01"))# 날짜형식


#################추가기능###############################
#### 그래프 안에서 Text를 표현

ggplot(data=economics,
       aes(x = date, y=psavert)) +
  geom_point() +
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) + 
  ylim(7,10) +  # 산점도를 부분만 잘라내기
  geom_text(aes(label=psavert, # Text 입히기 
                vjust=-0.5,    # 0은 기본위치
                hjust=-0.2))   # v는 vertical h는 horizon

# v에서 음수는 위 양수는 아래
# h에서 음수는 오른쪽 양수는 왼쪽


#### 사각형 덧씌우기 (특정영역 highlight)
# annotate("rect", x최소, x최대,y최소, y최대,투명도, 색상)
ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_point() +
  
  annotate("rect",
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha= 0.3,       # 투명도
           colour ="blue",   # 테두리색상
           fill ="red")     # 채우기 색상


# 특정영역에 arrow 그리기 / 문자열넣기/축이름 차트이름/
# 테마지정

ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_point() +
  
  annotate("segment",             # 직선.그림 넣기
           x=as.Date("1985-01-01"),
           xend= as.Date("1995-01-01"),
           y=7.5,
           yend=8.5,
           arrow=arrow(),         # 어떤 그림? 화살표
           color="blue") +
  
  annotate("text",                # 문자열 넣기
           x=as.Date("1985-01-01"),
           y=15,
           label="소리없는 아우성") +
  
  labs(x="연도", y="개인별 저축률", #축이름, 차트이름
       title = "연도별 개인저축률 추이") +
  theme_classic()   # 테마지정

help(annotate)
