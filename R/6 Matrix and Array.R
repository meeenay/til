###########################################################
###################### MATRIX #############################

# Matrix : 동일한  data type을가지는 2차원 형태의 자료구조

# 1.  Matrix의 생성
  # 1) matrix 함수 이용
    var1 = matrix(c(1:5)) # matrix의 생성기준은 열!! 
                          # 열이 고정된다는 의미->늘어나지않음
                        # 5행 1열짜리 matrix 생성
    var1
    
    var1 = matrix(c(1:10), nrow=2) # 숫자 10개로 매트릭스를 만들되
                                   # 두개의 행에 나눠 채워라
                                   # 열 기준으로 채워나감
    var1   #      [,1] [,2] [,3] [,4] [,5]
           # [1,]    1    3    5    7    9
           # [2,]    2    4    6    8   10
    var1 = matrix(c(1:10), nrow=3) # recycling 적용, warning
    var1                           # 3행 4열짜리 matrix
    
    var1 = matrix(c(1:10), nrow=2, byrow=T) # 행기준으로 채워짐
    var1 
    var1 = matrix(c(1:10), ncol=2, byrow=T) 
    
    
    
  # 2) vector를 연결해서 matrix를만들 수 있음
    # vector 가로방향, 세로방향으로 붙여서 2차원 형태로 만들수 있음
    var1 = c(1,2,3,4)
    var2 = c(5,6,7,8)
    
    mat1 = rbind(var1,var2)# 행단위로 붙인다
    mat1
    
    mat2 = cbind(var1, var2)
    mat2
    
    var1 = matrix(c(1:21), nrow = 3, ncol =7)
    var1    #3행 7열짜리 매트릭스
    
    var1[1,4] # 1행 4열의 10을 출ㄺ
    var1[2,]  # 2행의 모든 열
    var1[,3]  # 3열의 모든 행
  
    
    # 11 12 13 14 15 
    var1[c(2:3),c(4:5)]

    length(var1)    # 21
    nrow(var1)      # 3
    ncol(var1)      # 7

    
# matrix에 적용할 수 있는 함수가 있다
    # apply()를 이용해서 matrix에 특정 함수를 적용
    # apply()함수는 속성이 3개 들어감
    #  X => 적용할 matrix
    # MARGIN => 1이면 행기준, 2이면 열 기준
    # FUN => 적용할 함수명
    var1 = matrix(c(1:21), nrow = 3, ncol =7)
    var1
    apply(X=var1, MARGIN =1, FUN=max)
    apply(X=var1, MARGIN =1, FUN=mean)
    
    # 이미 제공되어 있는 함수만 이용할 수 있나?
    # 적용할 함수를 우리가 직접 만들어 사용할 수도 있다
    
    
## matrix의 연산
    # 1)matirx의 요소단위의 곱연산
    # 2) 전치행렬 구해보기
    # 3) 행렬곱 (matrix product)
    # 4) 역행렬 (matrix inversion) => 가우스 소거법이용
     var1 = matrix(c(1:6), ncol=3, byrow=T) ; var1
    
      var1 = matrix(c(1:6), ncol=3) ; var1
      var2 = matrix(c(1,-2,2,-2,1,-1), ncol=3); var2
      var3 = matrix(c(1,-2,2,-2,1,-1), ncol=2); var3
    
    # 1) elementwise product (요소단위 곱연산) *
      var1 * var2     # 같은 위치에있는 요소 끼리 연산
    
    # 2) matrix product(행렬곱) %*%
      var1%*%var2     # 오류  2행 3열과 2행3열을 곱할 수 없음 
      var1%*%var3     # 2행 2열의 행렬곱 결과 산출
    
    # 3) transpose (전치행렬) -> t()함수이용
      var1
      t(var1)       # 2행 3열을 3행 2열로 전치
      
    # 4) 역행렬: solve()
    #     matrix A가 nxn 일때 다음의 조건을
    #     만족하는 행렬B가 존재하면 행렬 B를 A의 역행렬이라함
    #     AB = BA = I (단위행렬 E)  
      solve(var1) # 현재 var1이 정방형이아니므로 error message
      var4 = matrix(c(1:4), ncol=2); var4
      solve(var4)
      
      
      
########################################################
####################### ARRAY ##########################
      
# Array : 3차원 이상, 같은 데이터 타입으로 구성
  
  # 1. Array의 생성 -> array함수 이용
      # 차원이 정해지지 않았으므로, 항상 dimension을 정의해야
      
      var1 = array(c(1:24), dim=c(2,3,4))
      var1
      
      var1 = array(c(1:24), dim=c(3,2,4))
      var1
    

      
##########################################################
######################
    
      
      