# flask 프레임워크를 로드 -> 프레임워크는 규모가 크기 때문에
# 전체를 로드하는게 아니라 일부만 로드 
from flask import Flask, render_template, request, redirect
# Flask : 웹서버를 구동, 특정 api(주소)를 생성해서 함수들과 연결
# render_template() : 작업 공간에서 templates라는 하위 폴더의 
#                     HTML 파일을 요청을 한 유저에게 보내주는 역할
# request() : 유저가 보낸 데이터를 확인하는 기능
# redirect() : 특정한 주소로 요청을 보내는 기능(웹 브라우져에서 특정 주소로 이동)
# Flask class를 생성
app = Flask(__name__)

# 첫번째 api를 생성
@app.route('/')
# 127.0.0.1:5000(root 주소) + '/' 해당 주소로 요청이 들어왔을때 -> 
# 바로 아래의 함수를 호출 -> 함수 이름의 조건 : 중복 사용 불가
def index():
    # render_template() 함수를 이용해서 html문서를 유저에게 돌려준다.(응답)
    return render_template('index.html')
    # return "<h1>Title</h1><p>abcdefg<b>hijk</b>lmn</p>"

# api 생성 
# /send_get주소를 생성 
@app.route('/send_get')
def send_get():
    # 유저가 보낸 데이터를 확인 






# 웹 서버를 실행 
app.run()