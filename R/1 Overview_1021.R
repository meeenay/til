# R의 주석은 #을이용함
# 주석을 이용하면한 줄이 몽땅 comment 처리

# 일반적으로 프로그래밍언어에서 Statement를종료하기 위해 사용하는";" (java, sas)
# 그러나 R은 ";"를 생략가능, 한 줄에 여러 Statement를 쓸 때만 ";"사용
# 코드 수행을 위해서는 Ctrl+Enter를 사용
# R은대소문자구문함(case sensitive)
# 변수 생성 시 camelcase로 작성함 (두단어를 연결해서 쓸때, 두 번째단어의 첫 글자를 대문자로 쓴다는 의미)
myResult # camelcase notation
MyResult # pascal notation
my_result # C언어의 일반적인 notation
myresult = 20 #가독성상 뭔가 이상하다고 느낌!!
#사용 추천 camelcase > my_result >MyResult  
# 세계적으로 관용적인 약속. 시스템상 에러를 유발하는 것은아님
######################################################

# 값 변수에 할당하기 #
myResult = 200 # assignment
myResukt <- 300 #assignmen
400 -> myResult #assignmen  *r의 특이한 점

# 변수 값콘솔에 출력#
myResult 
print(myResult)

#여러개의 값을 출력하려면 cat() 사용

print("결과값은: "  + myResult) # 다른 언어에서는 문자열 연결시키는 용도로 +가 사용되지만, R에서는 숫자끼리의 합에만 사용되므로 에러가 발생함 대신 

cat("결과값은 : ", myResult)

#####################################################
# 멤버를 이용한 변수 선언 # 
goods.price = 3000
goods.code = "001"
goods.name = "냉장고"
#---필수는 아니지만 의미론적으로 변수를 관리하기 좋은 방법

###################################################### 출력형식 살펴보기 # 
mySeq = seq(100) #  1부터 100까지 1씩 증가하는 숫자의 집합. 100 inclusive. 괄호 안숫자 100까지 포함해 산출됨
mySeq = seq(5,100) # 5부터 100까지 1씩증가하는 숫자의 집합
mySeq = seq(1,100,by = 2)
mySeq



