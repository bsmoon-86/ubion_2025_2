# 프레임워크 로드 
from flask import Flask, render_template, request, url_for
import pandas as pd
from invest import Quant, load_data


# Flask class 생성 
# 생성자 함수 필요한 인자 : 파일의 이름 
app = Flask(__name__)

# 네비게이터 -> 특정한 주소로 요청이 들어왔을때 함수와 연결
# route()함수에 인자가 의미하는것은? 
# root url + 주소(route함수에 인자) 
@app.route('/')
def index():

    return render_template('test.html')

@app.route("/aapl")
def aapl():
    df = pd.read_csv('csv/AAPL.csv')
    # Quant class 생성 
    quant = Quant(df)
    # Halloween 전략 사용
    hall_df, arr_rtn = quant.halloween()
    # hall_df의 인덱스를 초기화하고 기존의 인덱스는 유지 
    # 기존의 인덱스가 시간 데이터임으로
    hall_df.reset_index(inplace=True)
    cols = list(hall_df.columns)
    value = hall_df.to_dict('records')
    x = list(hall_df['Date'])
    y = list(hall_df['acc_rtn'])
    return render_template('index.html', 
                        columns = cols, 
                        values = value, 
                        axis_x= x, 
                        axis_y = y)

@app.route("/dashboard")
def dashboard():
    # 유저가 보낸 데이터를 변수에 저장 
    # get 방식으로 보낸 데이터는 request.args에 데이터가 딕셔너리 형태로 존재
    input_code = request.args['code']
    input_start_time = f"{request.args['s_year']}-{request.args['s_month']}-{request.args['s_day']}"
    input_kind = request.args['kind']
    # print(input_code, input_start_time, input_kind)
    # input_code를 이용하여 파일을 로드 
    # df = pd.read_csv(f"csv/{input_code}.csv")
    df = load_data(input_code, input_start_time)
    print(df.head(3))
    quant = Quant(df, _start = input_start_time, _col='Close')
    if input_kind == 'bnh':
        result, rtn = quant.buyandhold()
    elif input_kind == 'boll':
        result, rtn = quant.bollinger()
    elif input_kind == 'hall':
        result, rtn = quant.halloween()
    elif input_kind == 'mmt':
        result, rtn = quant.momentum()
    result.reset_index(inplace=True)
    result = result.loc[ result['rtn'] != 1,  ]
    cols = list(result.columns)
    value = result.to_dict('records')
    x = list(result['Date'])
    y = list(result['acc_rtn'])
    return render_template('index.html', 
                           columns = cols, 
                           values = value, 
                           axis_x = x, 
                           axis_y = y)



# 웹서버를 실행 
app.run(debug=True)