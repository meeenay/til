import requests

# 1. 요청 보내기 
# result = requests.get('https://naver.com')

# print(result) # response [200] 이라는 가공가능한 객체가 들어옴


# 2. response 객체를 문자열로 반환해서 받아보기
result = requests.get('https://naver.com').text
print(result)
print(type(result))
