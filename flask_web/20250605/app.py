from flask import Flask, render_template, request
import pandas as pd

# Flask class를 생성
# __name__ : 파일의 이름
app = Flask(__name__)

# corona.csv 파일을 로드 (index는 첫번째 컬럼으로 사용)
corona = pd.read_csv("./data/corona.csv", index_col=0)
# stateDt의 데이터를 기준으로 오름차순 정렬 
corona.sort_values(['stateDt'], inplace=True)
# 일일확진자 컬럼을 생성 -> 오늘의 총 확진자수 - 어제(전 행)의 총 확진자수
corona['일일확진자'] = ( 
    corona['decideCnt'] - corona['decideCnt'].shift(1)
 ).fillna(0)
# 일일사망자 컬럼을 생성 -> 전행의 데이터의 차이값
corona['일일사망자'] = corona['deathCnt'].diff(1).fillna(0)

# api 생성
@app.route('/')
def index():
    # 127.0.0.1:5000/ 요청이 들어왔을때 자동 호출
    # corona 데이터에서 stateDt, 일일확진자, 일일사망자 컬럼을 추출
    df = corona[ ['stateDt', '일일확진자', '일일사망자'] ]
    # 해당 데이터에서 가장 최근의 데이터의 값들을 추출
    date = df.iloc[-1, 0]
    decide = df.iloc[-1, 1]
    death = df.iloc[-1, 2]
    print(f"최근일 : {date}, 일일확진자수 : {decide}, 일일사망자수 : {death}")
    # 테이블에서 컬럼의 이름을 리스트로 생성
    col_list = list(df.columns)
    # 전체 데이터프레임을 dict 형태로 변환 -> to_dict()
    dict_data = df.to_dict(orient='records')
    print(f"데이터프레임의 컬럼의 목록 : {col_list}")
    print(f"데이터프레임 딕셔너리형 변환 : {dict_data[0]}")
    return ""





app.run(debug=True)