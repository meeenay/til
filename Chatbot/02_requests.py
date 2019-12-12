import requests

## 1. 요청 보내기 
# result = requests.get('https://naver.com')

# print(result) # response [200] 이라는 가공가능한 객체가 들어옴


## 2. response 객체를 문자열로 반환해서 받아보기
# result = requests.get('https://naver.com').text
# print(result) 
# print(type(result)) # 문자열로 가져옴



## 3. response 객체를 통해 상태 코드 받아보기 
result = requests.get('https://naver.com').status_code
print(result)
if result == 200:
    print('접속성공!')
elif result == 404 :
    print('페이지가 없네요...')

                 ## http 상태코드 : 200정상접속, 404.. 등등



