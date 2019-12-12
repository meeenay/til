# 네이버 금융 - 시장지표 - 원달러 환율 가져오기!


# 0. 관련 모듈 import
import requests
from bs4 import BeautifulSoup


# 1. 문자열 형태로 문서 가져오기 

url = 'https://finance.naver.com/marketindex/'

html = requests.get(url).text

# 2. BeautifulSoup 클래스 객체 받기 

soup = BeautifulSoup(html, 'html.parser')
print(type(soup))

# 3. 원하는 선택자 내용 가져오기

exchange = soup.select_one('#exchangeList > li.on > a.head.usd > div > span.value').text 
        # select_one: 하나의 string으로 끌어오므로, text 옵션을 적용할 수 있다 
        # select : 여러개의 string을 list형태로 가져오므로, text옵션이 먹히지 않는다.

# 4. 결과물 출력

print(exchange)