# Data Type : 저장된데이터의 성격(숫자, 문자열, 논리형)

# Data Structure : 	변수에 저장된 데이터의 메모리 구조

# R이 제공하는자료 구조 # 

 # 6를 기억하면 된다
 # 2개의 분류로 나누어진다 --> 같은 데이터 타입인가 아닌가 

  # 1.같은 데이터 타입
    # (1) Vector : 1차원, 같은 data type
    # (2) matrix : 2차원, 같은 data type
    # (3) array  : 3차원, 같은 data type 
        # <- R에서는 Array가 3차원임에 유의

  # 2. 다른 데이터 타입
    # (1)List: 1차원, 다른 data type
        # 중첩자료구조: 리스트의 칸 안에 다른 리스트 
        # or 벡터or 매트릭스 등이 들어갈 수 있다는 의미
    # (2) Data Frame : 2차원, 다른 data type
    # (3)Factor : 범주형 자료구조

  # 자료구성을 이해해야 분석특성을 정리할 수 있다. 
  # 따라서 기본적 형태와 활용을 예제로 이해 및 연습해야한다.

#############################################################

# 1. Vector
    # vector는 scalar의 확장, 1차원 선형구조
    # vector는 같은 data type으로 구성된다
    # vector는 첨자형태로 access가 가능하다 ([])
        # -> 즉 기호로 대괄호를 사용한다는 의미
    # R 인덱스는 1부터 시작함 (일반적인 언어는 0부터)
  # ??????인덱스와 첨자는 서로 같은 것

  # 1) Vector를 생성하는 방법
   # (1) combine함수를사용하여 생성( c() )
      #     일반적으로 규칙성이 없는 데이터를 이용해서 
      #   - vector를 생성할때 이용하거나
      #   - vector를 이용해서 다른 vector를 생성 (List와 구분주의)
      var1 = c(1,2,6,9,10)
      var1 
      mode(var1)
      var2 = C(TRUE, FALSE, TRUE)
      var2
      var3 = c("홍길동", "김길동","최길동")
      var3
      var4 = c(200,TRUE, "아우성") # "200" "TRUE" "아우성"
      var4      # <-모두 같은 데이터 타입으로잡힌다. 상위인 문자형으로
      var5 =c(var1, var2)  # 1 2 6 9 10 1 0 1
                           # 백터의 결합
      
    # (2) : 을 이용해서 vector를 생성할 수 있다
      #     numeric에서만 사용가능하고 1씩 증가하거나
      #     감소하는 숫자의 집합을 vector로 만들때 사용
      #     start:end 형태로 사용되고 둘 다 inclusive
      var1 = 1:5; var1    # 1 2 3 4 5
      var2 = 5:1; var2    # 5 4 3 2 1
      var3 = 3.4:10; var3 # 3.4 4.4 5.4 6.4 7.4 8.4 9.4
      
    # (3) Seq()를 이용해 VECTOR를 생성할 수 있다
      #   : 의 일반형으로 등차수열을생성해서 VECTOR화 시킬때 사용
      Var1 = seq(from=1, to =10, by=3) # 원형: readability 가 좋음
      var1 = seq(1,10,3)               # 원형의 속성을 생략한 버전
      var1
    
     # (4) rep()를 이용해서 vector를 생성할 수 있다
      #   replicate의 약자
      #   지정된 숫자만큼 반복해서 vector를 생성
      var1 = rep(1:3,times=3) ; var1 # 1 2 3 1 2 3 1 2 3
      var1 = rep(1:3, 3)             # 위와 동일. 1:3을 3번 반복하라
      var2 = rep(1:3, each=3)        # 1 1 1 2 2 2 3 3 3 
                                     # each는 속성을 생략할 수 없음
      
  # 2) vector의 데이터 타입을 확인하는 법
      mode(var1) # numeric
   
  # 3) vector안의 데이터의 개수를 알아내려면??
      # length 함수를이용해라
      var1 = c(1:10)
      var1 
      length(var1) # 10
      
      # length를 다른 용도로 사용할 수 있음
      var1 = seq(1,100, by=3) ; var1 
                # <- 3씩이었는데 by대신 length를 사용하면?
      var1 = seq(1,100, length=3) ; var1 #총 3개만 보여줌
      
      
  # 4) Vector에서 데이터 추출
    # vector의 사용은 []를이용해서 데이터 추출
      # 활용예시
      var1 = c(67,90,87,50,100) 
      var1
      # 이 백터에서 67을 꺼내고 싶다면?
      var1[1] # : 벡터의 첫 원소 추출 
      var1[5]
      var1[length(var1)]  # : 벡터의 마지막 원소 추출
      # vector를만들기 위해서 사용한 :, c(), rep()를 
      # vector 요소를 access하기위한 용도로 사용할수 있음
      var1[2:4]      # 90 87 50
      var1[c(1,5)]   # 67 100
      var1[seq(1,4)] # 67 90 87 50
      var1[6]        # NA
      # ★★★★★   "-" 는 제외의 의미 
      var1[-1]       # 90  87  50 100
                     # -1번째칸이 아니라, 역을 의미함. 
                     # 1번째 항을 제외한 나머지!!!!!!
      var1[-c(1:3)]  # 50 100
      

  # 5) vector 데이터의 이름
      var1 = c(67,90,50) ; var1
      names(var1) # Null
                  # vector의 각 데이터에 붙은 이름은 없음
      names(var1) = c("국어", "영어", "수학")
      var1
      names(var1)      
      
      var1[2]       # index를 이용해 vector data를 추출
      var1["영어"]  # name을 이용해 vector data를 추출
      
      
  # 6) vector의 연산
      # 수치형 vector는 scalar를이용해 사칙연산을 할 수 있음
      # 그리고 vector와 vector간의 연산도 수행할 수 있음
        var1 <-1:3   # 1 2 3
        var2 <- 4:6  # 4 5 6 
        var1; var2
        
        var1 * 2     # 2 4 6
        var2 + 10    # 14 15 16
        
        var1 + var2  # 5 7 9
        
        var3 = 5:10
        var1 + var3 # recycling rule (사이즈를 채워맞춰 연산됨)
                    #    1 2 3 1 2 3  
                    #    5 6 7 8 9 10
                    # ----------------
                    # =  6 8 10 9 11 13
        
        var4 = 5:9  # 5 6 7 8 9 
        var1 + var4 # 1 2 3 1 2 
                    # 5 6 7 8 9 
                    # --------------
                    # 6 8 10 9 11   # 동작은 가능.but warning
        
      
      # vector간의 집합 연산
        # union()     : 합집합
        # intersect() : 교집합
        # setdiff()   : 차집합
      
          var1 = c(1:5)
          var2 = c(3:7)
          union(var1,var2)
          intersect(var1,var2)
          setdiff(var1,var2)
    
      # vector간의 비교 (두 vector가 같은가 다른가 확인)
        # identical 
          #         : 비교하는 두 vector의 요소가 개수, 
          #          순서, 내용이 같아야지 TRUE를 return
          var1 = 1:3
          var2 = 1:3
          identical(var1, var2) # 같은 vector이기때문에 TRUE
          
          var1 = 1:3
          var2 = c(1,3,2)
          identical(var1, var2) # 순서가 다르기 때문에 False
          
         # setequal 
          #         : 비교하는 두 vector의 크기, 
          #           순서와 상관없이 내용만을 비교
          var2 = c(1,3,2)
          setequal(var1, var2) # 순서가 달라도 내용동일 TRUE
          
          var3 = c(1, 3, 2, 1, 1, 1, 3, 3)
          var1 = 1:3
          setequal(var1,var3) #길이가 달라도 요소가 같아 TRUE

      # 요소가 없는 vector
          var1 = vector(mode="numeric", length=10) 
                # vector를만드는 함수 이용
          var1
          var1 = vector(mode="logical", length=10) 
          # default는 false
          var1
          var1 = vector(mode="character", length=10) 
          # default는 ""
          var1

                        
      
      
      
      
      
    
      
            
      
      
      
          
   
      
      
      
      
      
      
    

