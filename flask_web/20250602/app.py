# flask 프레임워크를 로드 
# 프레임워크 -> 굉장히 많은 변수, 함수, 클래스의 덩어리
# 일반적으로 프레임워크 로드 시에는 전체를 로드 하지 않는다. 
# 특정 모듈에서 일부의 기능만 가지고올때 -> from ... import ...
# Flask -> 웹서버를 실행하고 주소를 생성하여 함수에 연결하는 기능
# 함수에서 return에 HTML과 연결해주는 기능을 가진 함수를 
# render_template() 함수는 HTML문서를 
# 기본 경로가 현재 경로에서 templates하위 폴더에서 가져온다. 
from flask import Flask, render_template

# Flask class 생성
# Flask class는 생성자 함수에는 필수 인자가 1개 필요
# 파일의 이름 -> app.py -> 
# __name__을 사용하면 파일이 이름이 변경되도 이름을 그대로 불러온다.
app = Flask(__name__)

# route() -> 네비게이터 함수 
# 특정한 주소로 요청이 들어왔을때 바로 아래의 함수와 연결을 해주는 기능
# route('/') -> root url(127.0.0.1:5000) + '/' 
# -> 해당 주소로 요청이 들어왔을때 -> 바로 아래의 함수(index())호출
@app.route('/')
def index():
    # return 'Hello Flask'
    # templates 폴더에 있는 index.html을 되돌려준다. 
    return render_template('index.html')

# route('/second') -> root(127.0.0.1:5000) + '/second'
# -> 주소로 요청이 들어왔을때 (웹브라우져에서 해당 주소를 입력하고 엔터키를 입력했을때)
# 아래의 함수를 호출(함수 생성시 조심할 점 : 함수의 이름은 자유지만 중복은 불가)
@app.route("/second")
def second():
    return "Second Page"



# Flask 안에 존재하는 서버를 생성하는 함수를 호출
app.run()


# http://172.30.1.187:8000