getwd()
setwd("C:/r_lecture")
.libPaths("C:/r_lecture/lib")
# 자연어 처리 기능을 이용해보자

# # KoNLP package 를 이용!
# Korean Natural Language Process
# 해당 패키지 안에 사전이 포함되어 있음

# 이것은 소리없는 아우성!
# 3가지의 사전이 포함
# 시스템 사전(28만개),
# 세종 사전(32만개),
# NIADic 사전(98만개)

# JAVA 기능을 이용! JDK를 설치해야 함
# 시스템에 JRE가 설치되어 있어야 한다.
# JRE를 설치를 하긴 했는 데 R package가 JRE를 찾아서 써야한다.
# JAVA_HOME 환경변수를 설정해야 한다.
# 설정하고 껐다가 다시 켜야한다.

# 참고로 영문 NLP => openNLP, Snowball
# package를 많이 이용
install.packages("KoNLP")
library(KoNLP)

# 어떤 사전을 이용할 것인지 명시
useNIADic() # colsole 창에 엔터를 치면 다시 다운로드한다.


# 예시
tmp = "이것은 소리없는 아우성"
extractNoun(tmp)


# 자료불러오기
library(xlsx)
txt<- readLines("C:/r_lecture/data/11.06/hiphop.txt",
                encoding = "UTF-8")
head(txt)

library(stringr)
# 정규표현식을 이용해서 특수문자를 모두 찾아서 공백으로 변환
txt<-str_replace_all(txt,"\\W"," ")
head(txt)

## 형태소를 분석할 데이터가 준비 되었어요!
## 함수를 이용해서 명사만 뽑아내기
nouns <- extractNoun(txt)
head(nouns)
# 명사를 추출해서 list 형태로 저장

length(nouns)

# list형태를 vector를 변환
words<-unlist(nouns)
head(words)
length(words)


# 워드클라우드를 만들기 위해서 많이 등장하는 명사만 추출
wordcloud<-table(words)           # 빈도수 파악
class(wordcloud)
df<-as.data.frame(wordcloud,
                  stringsAsFactors = F)
df
View(df)

# 빈도수가 높은상위 20개 단어들만 추출
# 한 글자 짜리는 의미가 없어요!
# 두 글자 이상으로 되어있는 데이터 중 빈도수가 높은 상위 20개 단어들만 추출(한글자 짜리는 의미가 없어요!)

library(dplyr)
word_df<-df%>%
  filter(nchar(words)>1)%>%
  arrange(desc(Freq))%>%
  head(20)
View(word_df)

# 데이터가 준비되었으니 워드 클라우드를 만들어보아요
install.packages("wordcloud")
library(wordcloud)

# 워드 클라우드에서 사용할 색상에 대한 팔레트를 설정
# Dark2라는 색상목록에서 8개의 색상을 추출
pal <- brewer.pal(8,"Dark2")

# 워드 클라우드는 만들때마다 랜덤하게 만들어져요!
# 랜덤하게 생성되기 때문에 재현성을 확보할 수 없음!
# 재현성을 확보하기 위해 
# 랜덤함수의 시드값을 고정시켜서 항상 같은 워드 클라우드가 만들어 지게 설정
set.seed(1111)
wordcloud(words=word_df$words,
          freq=word_df$Freq,
          min.freq=5,
          max.words=200,
          random.order=F, # 고빈도 단어 중앙배치 여부
          rot.per=.1,     # 회전시킬 단어비율
          scale=c(4,0.3), #
          colors=pal)



### 네이버 영화댓글 사이트
### 특정 영화에 대한 review를 
### crawling해서
### wordcloud를 작성



library(rvest)

review<-vector(mode = "character",10)
extract_comment<-function(idx){
  url <-"https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=179482&target=after";
  page<-"page=";
  request_url<-str_c(url,"&",page,idx);
  html_page <-read_html(request_url,encoding = "CP949")
  for (idx in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   idx,
                   ']/td[2]/text()')
    nodes = html_nodes(html_page,
                       xpath=myPath)
    txt <- html_text(nodes, trim = TRUE)
    review[idx] = txt[3]
  };
  df<-data.frame(review,stringsAsFactors = F)
  return(df)
}

result_df = data.frame();
for(i in 1:10){
  tmp<-extract_comment(i);
  result_df <- rbind(result_df,tmp);
}

View(result_df)
vec<-result_df$review
vec<-str_replace_all(vec,"\\W"," ")
vec<-gsub('[ㄱ-ㅎ]','',vec)
vec<-gsub('(ㅜ|ㅠ)+','',vec)
vec<-gsub('\\(이모티콘\\)','',vec)
vec<-gsub('[~!@#$%^&*()_+=?]<>','',vec)
head(vec)
movienouns <- extractNoun(vec)
head(movienouns)
moviewords<-unlist(movienouns)
head(moviewords)
moviecloud<-table(moviewords)       # 빈도수 파악
head(moviecloud)
df<-as.data.frame(moviecloud,
                  stringsAsFactors = F)
df
head(df)
movie_df<-df%>%
  filter(nchar(moviewords)>1)%>%
  arrange(desc(Freq))%>%
  head(40)

pal <- brewer.pal(8,"Dark2")
set.seed(1111)
wordcloud(words=movie_df$moviewords,
          freq=word_df$Freq,
          min.freq=5,
          max.words=200,
          random.order=F, # 고빈도 단어 중앙배치 여부
          rot.per=.1,     # 회전시킬 단어비율
          scale=c(4,0.3), #
          colors=pal)




#################조커로 테스트 ########



library(rvest)

extract_comment = function(i) {
  url <- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=167613&target=after";
  
  page <- "page="
  request_url <- str_c(url,"&",page,i)
  html_page <-read_html(request_url, encoding="CP949")
  
  review = vector(mode="character", length = 10)
  
  for (idx in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   idx,
                   ']/td[2]/text()')
    nodes = html_nodes(html_page,
                       xpath=myPath)
    txt <- html_text(nodes, trim = TRUE)
    review[idx] = txt[3]
  }
  df <- as.data.frame(review,stringsAsFactors = F)
  return(df)
}

result_df = data.frame();
for(i in 1:100) {
  df = extract_comment(i)
  result_df = rbind(result_df,df)
}

View(result_df)

library(stringr)

vec<-str_replace_all(result_df$review,"\\W"," ")
vec<-gsub('[ㄱ-ㅎ]','',vec)
vec<-gsub('(ㅜ|ㅠ)+','',vec)
vec<-gsub('\\(이모티콘\\)','',vec)
vec<-gsub('[~!@#$%^&*()_+=?]<>','',vec)
head(vec)

words<-extractNoun(vec)
head(words)
wvec <- unlist(words)
head(wvec)
wtable <- table(wvec)
head(wtable)
View(wtable)
words_df <-as.data.frame(wtable, stringsAsFactors = F)
View(words_df)

library(dplyr)

result_cm <- words_df %>% 
  filter(nchar(wvec)>1,
         !wvec%in%c("조커","영화")) %>%
  arrange(desc(Freq)) %>%
  head(50)

View(result_cm)
help(palette)
pal <- brewer.pal(6,"Dark2")
set.seed(888)
wordcloud(words = result_cm$wvec,
          freq = result_cm$Freq,
          min.freq=5,
          max.freq=200,
          random.order=F, 
          rot.per=.1,     
          scale=c(9,0.1),
          colors=pal)

install.packages("extrafont")
library(extrafont)
# 모양이 안이쁘네?

font_import()
windowsFonts(songeulssi=windowsFont("휴먼편지체 보통"))

install.packages("SnowballC")
library(SnowballC)