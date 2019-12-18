## 파이썬 설치 및 개발환경 세팅

### 1. 파이썬 설치

#### 1.1 설치

- [파이썬 공식 홈페이지](https://www.python.org/)

- 최신 버전 다운로드 및 설치파일 실행
  - 설치 첫 화면 `ADD Python 3.x TO PATH` 옵션 반드시 체크

#### 1.2 VSCode 설정

- `Ctrl + shift + P`
- `Terminal`: `Select Default Shell` 클릭
- `Git Bash`클릭 후 VSCode 내장 터미널 확인
  	1. 상단 메뉴 View -> Terminal 클릭
   2. Ctrl + 백틱(`)
      - 기본 터미널이 Bash로 나오게 바뀐 걸 확인할 수 있다.



#

### 2. 개발환경 세팅

#### 2.1 gitignore

> venv를 이용해서 가상환경에서 작업을을 할 때, 기본적으로 venv 파일을 통째로 git에 올리지 않는다.
>
> 프로젝트 폴더에 .gitignore을 생성하자

- gitignore.io에서 venv 입력하고 생성 및 복사
- `.gitignore`  파일에 복사 붙여넣기



#### 2.2 가상환경 만들기

- 가상환경 생성

  가상환경을 사용할 프로젝트 폴더로 들ㅇ온 것을 확인하고 가상환경을 생성한다.

  ```bash
  ~/Desktop/chat/chatbot
  $ python -m venv venv(가상환경 이름)
  ```

  - 정확하게는 `python -m venv [가상환경 이름]` 이지만, 일반적으로 venv라고 이름 붙인다

  - 설치가 잘 되었으면 venv 폴더가 생긴 것을 확인할 수 있다.

    ```bash
    chat/
    	chatbot/
    		.gitignore
    ```

- 가상환경 진입

  ```bash
  ~/Desktop/chat/chatbot
  $ source venv/Scripts/activate (for windows)
  $ source venv/bin/activate (for Mac)
  ```

  가상환경 진입에 성공하면 좌측 상단에 (venv)라는 가상환경 이름이 출력된다.

  ```bash
  (venv)
  $
  ```

- 가상환경 탈출

  경로 상관 없이 아래 명령어를 입력하면 가상환경에서 나오게 된다

  ```bash
  (venv)
  $ deactivate
  ```

#### 2.3 VSCode - 가상환경 진입 관련 설정

> 매번 source blah blah 적으려니 너무 귀찮다
>
> VSCode 기능을 사용해서 터미널을 실행할 때 자동으로 해당 명령어가 실행되게 만들어보자

- VSCode 왼쪽 메뉴 최하단 - Extensions 진입
  - Python 검색해서 제일 상단의 확장프로그램 설치
- `Ctrl + Shift + P`
- Python: Select Interpreter 클릭
- 사용할 가상환경 목록 출력 -> 클릭 ... `(venv) .venv/Scripts/activate ...`
- 설정이 끝나면 앞으로 터미널을 켜면 자동으로 가상환경에 진입되는 것을 확인할 수 있다.
- 주의사항!!!
  - 위에서 설정한 내용은  `.vscode` 폴더에 있는 `settings.json`에 명시되어 있으므로
    자동 가상환경 진입 기능을 사용하려면 open folder로 폴더를 선택할 때 `.vscode` 폴더가 존재하는 폴더를 선택해야 한다
  - `vscode` 폴더가 Charbot 폴더에 있기에 open folder -> Chatbot 폴더를 선택하면 된다.



#### 2.4 원격 저장소에 올려둔 가상환경 불러오기

> 기본적으로 원격 저장소에는 가상환경 폴더(view)를 통째로 올리지 않는다
>
> 그 이유는 가상환경 폴더에는 각종 라이브러리들이 설치되는 장소이기에 
> 파일의 갯수가 많고 용량이 크다
>
> 또한 개개인의 PC 환경이 다르기에 본인의 PC에서 잘 돌아가던 가상환경 세팅이라도 
> 다른 사람에게 통째로 건네주면 그 사람의 환경과 충돌할 위험이 있다.
>
> 따라서 프로젝트 환경에 필요한 패키지 목록만 넘겨주고 
> 이 프로젝트를 받아서 실행 혹은 개발하고자하는 사람이 
> 해당하는 패키지들을 설치해서 사용할 수 있게한다.

- 현재 상황
  
  ```bash
  $ pip freeze > requirements.txt
  ```
  
  
  
  - requirements.txt가 만들어져 있고 
    이 안에 가상환경에 필요한 패키지 목록들이 나열되어 있다.
  - 내가 작업하고자하는 환경에는 파이썬과 가상환경이 세팅되어있지 않다

1. 원격 저장소 내용 가져오기

   - clone을 이미 받아두었을 경우

     ```bash
     $ git pull origin master
     ```

     

   - 아무것도 없는 경우

     ```bash
     $ git clone GithubUrl
     ```

   - 원격 저장소의 내용과 내 로컬 환경의 내용이 동기화된 것을 확인할 수 있다.

2. 가상환경을 설치할 폴더로 들어가서 Git Bash를 연다.

   ```bash
   ~/Desktop/chat/chatbot
   $ 
   ```

   ```bash
   chat/
   	chatbot/
   		python-recap/
   		.gitignore
   		requirments.txt
   ```

3.  가상환경을 설치한다.

   ```bash
   ~/Desktop/chat/chatbot
   $ python -m venv venv(가상환경 이름)
   ```

4. 가상환경 폴더 생성 확인

   ```bash
   chat/
   	chatbot/
   		venv/
   		python-recap/
   		.gitignore
   		requirments.txt
   ```

5. 가상환경 진입해서 패키지 목록 확인

   ```bash
   ~/Desktop/chat/chatbot
   $ sourve venv/Scripts/activate
   
   (venv)
   $ pip list
   ...
   ...
   ```

6. 프로젝트에 필요한 패키지들을 설치한다.

   - 필요한 패키지들은 requirements.txt에 저장되어 있다.

     ```bash
     ~/Desktop/chat/chatbot
     $ pip install -r requirements.txt
     ...
     ...
     
     ```

     ```bash
     $ pip list
     ```

     requirements.txt에 나열되어있는 패키지들이 설치된 것을 확인할 수 있다.



---
## 웹 스크랩핑

### 1. requests

#### 1.1 설치

```bash
$ pip install requests
```

```python
import requests
```

#### 1.2 기본 사용법

- `requests.get(URL)`: Response 객체 리턴
- `requests.get(URL).text`: Response 내용이 문자열(str)로 리턴
- `requests.get(URL).status_code`: 상태 코드 리턴(200, 404, ...)



#### 2. BeautifulSoup

##### 2.1 설치

```bash
$ pip install BeautifulSoup4
```



##### 2.2 기본 사용법

- `.select(선택자)`: 해당하는 태그들을 히스트 형태로 리턴
- `.select_one(선택자)`: 해당하는 태그 하나를 리턴



#### 3. Python 문법 +

##### 3.1 문자열 삽입(문자열 포매팅)

- 파이썬 3.0이상 -> **`fotmat`함수를 이용한 포매팅**
- 파이썬 3.6이상 -> **`f-string` 포매팅**

```python
# format 함수
"{1} {0}".format('one','two')

# f-string
a, b='one','two'
f'{a}, {b}'
```



---

## Flask

### 1. 설치 및 개발서버 실행



### 2. Flask 기초

#### 2.1 Render Template

> 단순 문자열을 리턴해주지않고, 미리 준비해둔 템플릿을 사용장게 보여주자

- templates 폴더 생성

  app.py와 같은 경로에 템플릿 폴더를 생성한다

  ``` 
  flask/
  	templates/
  		index.html
  		...
  	app.py
  ```

- app.py 코드 수정

  ```python
  from flask import Flask, render_template
  
  @app.route('/')
  def hello_world():
      return render_template('index.html')
  ```

  

#### 2.2 Variable Routing

> URL을 통해 사용자에게 임의의 값을 입력받는다
>
> 데이터를 적절하게 가공해서 사용자에게 응답을 해준다

URL로 요청을 받고, 단순 문자열 형태로 돌려줄 수 있다.
```python
# 인사해주는 페이지
@app.route('/greeting/<string:name>')
def greeting(name):
    return f'{name}, hi'
```
마찬가지로 미리 준비해 둔 템플릿을 리턴해줄 수도 있다.
```python
# 세제곱을 돌려주는 페이지
@app.route('/cube/<int:number>')
def cube(number):
    result=number ** 3
    return render_template('cube.html', number=number,result=result)
```



#### 2.3 템플릿 엔진(jinja2) 활용하기

> 함수 안에서 데이터를 가공한 뒤 HTML 태그 형태로 가공해서 보내주는 작업은 너무나 번거롭고 힘들다
>
> 따라서 단순 문자면 문자, 리스트면 리스트그대로 템플릿에 넘겨준뒤 Flask에 내장된 
> 템플릿 엔진을 통해 템플릿 단에서 제이문을 이용해서 데이터를 가공해보자

- **조건문**

  ```python
  @app.route('/greeting/<string:name>')
  def greeting(name):
      return render_template('greeting.html',html_name=name)
  ```

  ```html
  {% if html_name == '혁재' %}
  	<h3>{{html_name}} Admin</h3>
  {% else %}
  	<h3>안녕! {{html_name}}</h3>
  {% endif %}
  ```

- **반복문**

  ```python
  @app.route('/movie')
  def movie():
      movies=['나이브스 아웃','조커','엔드게임']
      return render_template('movie.html',movies=movies)
  ```

  ```html
  <h3>재미있는 영화 목록</h3>
  <ol>
      {% for movie in movies %}
     	<li>{{ movie }}</li>
      {% endfor %}
  </ol>
  ```



### 3. Flask의 요청(Request)-응답(Response)

> 웹은 기본적으로 요청-응답이라는 두 개의 로직으로 동작한다

#### 3.1 Ping-Pong

- 사용자가 `/ping`이라는 경로로 들어오면 우리 서버에 어떠한 데이터를 보낼 수 있는 form이 포함되어 있는 템플릿 보여줌

  ```python
  @app.route('/ping')
  def ping():
      return render_template('ping.html')
  ```

  ```html
  <form action="/pong">
      age: <input type="text" name="age"><br>
      <input type="submit">
  </form>
  ```

- 사용자가 제출 버튼을 누르고 우리 서버의 `/pong` 경로로 요청을 보내면,
  서버 내부적으로 데이터를 가공한 뒤 사용자에게 템플릿을 돌려주는 방식으로 응답한다

  ```python
  @app.route('/pong')
  def pong():
      age=request.args.get('age')
      return render_template('pong.html',age=age)
  ```

  ```html
  <h4>요청 받음, 응답 전송</h4>
  <h5>{{age}}</h5>
  ```

  

### 4. Flask 유잼

#### 4.1 신이 나를 만들 때