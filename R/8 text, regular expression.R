##################################################
############### 문자열 처리 방법 ##################

# 빅데이터 : 많은 양의 데이터
#          : 3V
#          : 1. Volume   : 많은 양의 데이터
#          : 2. Velocity : 속도
#          : 3. Variety  : 다양성 -> 정형에서 비정형까지

# 일반적으로 빅데이터 처리는 다양한 문자열 처리를  
# 동반하는 경우가 많다

# 문자열 처리는 stringr package를 이용하면
# 쉽고 편하게 할 수 있다


install.packages("stringr")
library(stringr)

var1 = "Honggd1234Leess9032YOU25최길동2009"

# 1. 문자열의 길이를 구하기
    str_length(var1) # 31 (한글 1글자도 1개)
        length(var1) #length와 구분(요소개수?)

# 2. 
    str_locate(var1, "9032")  # 지정한 변수(var1)에서 9032의
                              # start와 end위치를 index 해줌
    # 이 때 산출되는 데이터 자료 구조를 확인해보자
    class(str_locate(var1, "9032"))
    # ** mode()는 데이터 타입을 class()는 데이터 구조를 확인
    
# 3. 부분문자열을 구하자
    str_sub(var1, 3, 8) # (변수,시작,끝)  
                        # 시작과 끝 둘 다 inclusive
# 4. 대소문자 변경
    str_to_lower(var1) 
    str_to_upper(var1)    

# 5.문자열 교체
    var1 = "Honggd1234Hongss9032YOU25최길동2009"
    str_replace(var1,"Hong","KIM") # Hong 두개 중 첫 Hong 변경
    str_replace_all(var1,"Hong","KIM")

# 6. 문자열 결함
    var2 = "홍"
    var3 = "길동"
    
    str_c(var2,var3)
    

# 7. vector 문자열 결합
    var1 = c("홍길동" , "김길동", "최길동") 
    # 세가지를 연결하기
    
      # 1) str_c를쓴다면? 
          str_c(var1) 
          # 오작동.str_c는 변수 두 개를 연결할 때사용했음
    
      # 2) paste(변수, collapse= "기준")
          paste(var1, collapse = "-")
          # "홍길동-김길동-최길동"
          # 벡터 안의 문자 여려개를 연결 할 때 사용!!

          
# 8. 문자열 분할
    var1 = "Honggd1234,Leess9032,You25,최길동2009"
      # ,를 기준으로 문자를 분리해 벡터형식으로 출력하기
    
    str_split(var1,",") # (문자열변수, "분할기준")
    
      # str_split의 return type은 List임
    class(str_split(var1,",")) # list    
    
    
    
#########################################################
############ 정규표현식 (regular expression) ###########
    
# 문자열 처리를 쉽고 편하게 하기 위해서 사용하는
# 정규표현식 (regular expression)
    
    str_extract(변수명,"조건")# 조건부합 첫 번째 문자열을 추출
    str_extract_all() # 조건에 맞는 모든 문자열을 추출
    # 조건에 사용되는 # [] 와 {} 사용법 이해하기
    
    #예제
    var1 = "Honggd1234,Leess9032,YOU25,최길동2009"
    str_extract(var1,"[a-z]{4}") # [a-z]:영문자 소문자 1개 의미                                 # {4} : []가연속적으로 4개 반복
                          #[a-z]{4} : 소문자 4개 연속을 추출
    str_extract_all(var1,"[a-z]{4}") 
    str_extract_all(var1,"[A-Z]{2}") 
    str_extract_all(var1,"[a-z]{2,}") # ,는 이상을 의미함
    str_extract_all(var1,"[a-z]{2,3}")# 2개~3개 연속 추출
    
    
    str_extract_all(var,"34") # 같은것을추출해줌
    
    # 한글만추출하기
    str_extract_all(var1,"[가-힣]{2,}")
    str_extract_all(var1,"[0-9]{2,}") 
    
    # 한글을 제외한 나머지 문자들을 추출
    var1 = "Honggd1234,Leess9032,YOU25,최길동2009"
    str_extract_all(var1,"[^가-힝]{5}") #!이 아닌 ^을 쓴다
    
    
    # *****str_sub와 구분할 것
    # str_sub는 시작점과 종료점의 인덱스를 지정하여 추출
    # vector형태로 산출
    
    
    # 주민등록번호를검사해 보자
    myId = "801112-1210419";
    str_extract_all(myId,"[0-9]{6}-[1-4][0-9]{6}");
    