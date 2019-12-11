import webbrowser

artlist = ['민수', '백예린','방탄소년단']

for artist in artlist:
    webbrowser.open('https://naver.com/search.naver?query='+artist)


# ---- webbrowser를 여는 코드
    # webbrowser.open('https://naver.com')
    # https://search.naver.com/search.naver?query=방탄소년단 # ?이후를 query string이라 함 
