import random
from datetime import datetime
from flask import Flask, render_template, request
app = Flask(__name__)

# request: 사용자가 요청한 것을 받아 추출해주는 모듈/함수

# @app.route('/')
# def hello_world():
#     return 'Ridhdhdhdh!'

@app.route('/')
def hello_world():
    return render_template('index.html')


@app.route('/mulcam')
def mulcam():
    return '20층 스카이라운지 맛집'

@app.route('/dday')
def dday():
    today = datetime.now()
    new_year = datetime(2020,1,1)
    result = new_year - today

    return f'<h1>더 성숙해지기까지 {result.days}일 남았습니다!</h1>'
    # return 안에 html 태그를 쓸 수도 있다. 
    # 그러나 html 페이지를 만들어 연결하는게 더 효율적이므로 아래에서 연습해보자


''' 사용자로부터 이름을 받아 데이터를 내보내주는 페이지 만들어보기'''
@app.route('/greeting/<string:name>')
def greeting(name):
    return render_template('greeting.html', html_name=name)
                                            # html_name은 name을 받아서 template에서 사용할때 적용할 이름
                                            # = 받은 이름 --> 이것을 html을 통해 출력하려면 html문서에 {{html_name}}로 표시해줘야





'''값을 받아 계산해 세 제곱을 돌려주는 페이지 '''
@app.route('/cube/<int:number>')
def cube(number):
    result = number **3
    # return f'{number}의 세제곱의 값은 {number**3}입니다'
    return render_template('cube.html', number=number, result = result)


# 인원 수에 맞게 메뉴를 추천하는 페이지 
@app.route('/lunch/<int:people>')
def lunch(people):
    menu = ['보쌈수육정식', '고추잡채덮밥', '돼지불백', '샐러드', '히레카츠']
    # order = random.sample(menu, people)

    order = [random.choice(menu) for i in range(people)] # 중복 허용 O
    return str(order)

@app.route('/movie')
def movie():
    movies = ['나이브스 아웃', '조커', '엔드게임']
    return render_template('movie.html', movie_list=movies)




''' 사용자의 요청, 응답 구조를 연습해보기 ping-pong'''

@app.route('/ping')
def ping():
    return render_template('ping.html')


@app.route('/pong')
def pong():
    age = request.args.get('age')
    return render_template('pong.html', age = age)
    

 # 보내는 서버를 타 서버로 연동할 수도 있다  (naver)
@app.route('/naver')
def naver():
    return render_template('naver.html')

# google로 연동해보자 
@app.route('/google')
def google():
    return render_template('google.html')








''' 봉봉과 유사한 사이트 만들어보기 '''

# 사용자로부터 입력받을 페이지를 전송해줌
@app.route('/vonvon')
def vonvon():
    return render_template('vonvon.html')

@app.route('/godmademe')
def vonvonresult():
    name = request.args.get("me")
    first_op = ["미모", "기럭지", "착한 성품", "못생김","돈", "지능" ]
    second_op = ["싹수", "애교", "친절함", "못생김","재물운", "방귀쟁이" ]
    third_op = ["물욕", "식욕", "탐욕", "못생김","돈"]
    first = random.choice(first_op)
    second = random.choice(second_op)
    third = random.choice(third_op)
    return render_template('godmademe.html', name = name, first= first, second=second, third = third)


    # sample을 사용한 경우 (list 형태로 들어옴)
    tep = random.sample(first_op,1)
    print(temp,type(tmp, temp[0]))

    # choice 사용한 경우 (str 형태로 들어옴)
    first = random.choice(first_options)
    print(first,type(first))

    









# app.py 가장 하단에 위치
    # 1. 앞으로 flask run으로 서버를 키는게 아니라, python app.py로 서버를 실행한다
    # 2. 내용이 바뀌어도 서버를 껐다 키지 않아도 된다
if __name__ == '__main__':
    app.run(debug=True)