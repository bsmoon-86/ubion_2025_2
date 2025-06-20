# 프레임워크 로드 
from flask import Flask, render_template, request, url_for

# Flask class 생성 
# 생성자 함수 필요한 인자 : 파일의 이름 
app = Flask(__name__)

# 네비게이터 -> 특정한 주소로 요청이 들어왔을때 함수와 연결
# route()함수에 인자가 의미하는것은? 
# root url + 주소(route함수에 인자) 
@app.route('/')
def index():
    return render_template('index.html')


# 웹서버를 실행 
app.run(debug=True)