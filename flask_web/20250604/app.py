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

user_data = {
    'id' : 'test', 
    'pass' : '1234', 
    'nickname' : 'ubion'
}


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
    # 유저가 보낸 데이터를 확인 -> 유저가 보낸 데이터는 request
    # get방식으로 보낸 데이터는 requset 안에 args에 데이터가 존재 
    print(f"유저가 보낸 데이터 : {request.args}")
    # request.args에는 유저 보낸 데이터 : 
    # {input_id : test, input_pass : 1234}
    # 유저가 보낸 아이디 값 : request.args['input_id']
    user_id = request.args['input_id']
    user_pass = request.args['input_pass']
    print(f'유저가 입력한 아이디 : {user_id}, 비밀번호 : {user_pass}')
    return ""

# post 방식의 api 생성 
# /send_post라는 post 형식으로 주소 생성
@app.route('/send_post', methods=['post'])
def send_post():
    # post 방식으로 보낸 데이터를 로드 
    # post 방식으로 보낸 데이터는 request안에 form에 존재
    print(f"유저가 보낸 데이터 : {request.form}")
    # 유저가 보낸 아이디 값
    user_id = request.form['input_id']
    user_pass = request.form['input_pass']
    print(f"유저의 id : {user_id}, pass : {user_pass}")
    # user_data와 user_id, user_pass 비교 -> 모두 참이라면 로그인이 성공
    if (user_id == user_data['id']) and \
          (user_pass == user_data['pass']):
        # 로그인이 성공
        # return "로그인 성공"
        # user_data에서 nickname을 추출 
        nick = user_data['nickname']
        # render_template()함수를 이용하여 페이지와 닉네임을 보낸다. 
        return render_template('main.html', user_nick = nick)
    else:
        # return "로그인 실패"
        # 로그인이 실패했을때는 로그인화면(root)로 돌아간다. 
        return redirect('/')
    
@app.route('/test')
def test():
    return render_template('test.html')





# 웹 서버를 실행 
app.run(debug=True)