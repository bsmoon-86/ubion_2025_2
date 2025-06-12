import requests
import pandas as pd
from bs4 import BeautifulSoup as bs

codes = []
# 유저가 입력한 종목코드를 codes 추가 
while True:
    # 유저가 값을 입력하고 그 값을 변수에 저장 
    code = input("조회할 종목의 코드를 입력하시오 : (0 입력시 코드 추가 종료)")
    if (code == '0') or (len(codes) > 10):
        break
    codes.append(code)



for code in codes:
    base_url = "http://finance.naver.com/item/main.naver?code="
    res = requests.get(
        base_url + code
    )
    # 응답 데이터를 문자형으로 받아서 BeautifulSoup class로 파싱
    soup = bs(res.text, 'html.parser')

    # 파일의 이름으로 사용할 종목명을 추출 
    # div 태그 중 class가 h_company 태그를 선택
    div_data = soup.find(
        'div', attrs = {
            'class' : 'h_company'
        }
    )
    try:
        # div_data에서 h2태그를 선택해서 문자를 추출 
        company_name = div_data.find('h2').get_text().rstrip()
    except:
        print(f'{code}는 없는 종목 코드입니다. ')
        continue

    # soup에서 div중 class가 invest_trend인 태그를 선택 
    invest_data = soup.find(
        'div', attrs = {
            'class' : 'invest_trend'
        }
    )

    dfs = pd.read_html( str(invest_data) )
    # 결측치가 포함된 행을 제거 
    trade_info = dfs[0].dropna(axis=0).reset_index(drop=True)
    fori_org = dfs[1].dropna(axis=0).reset_index(drop=True)

    trade_info.to_csv(f"data/{company_name}_거래원정보.csv", index=False)
    fori_org.to_csv(f"data/{company_name}_외국인,기관.csv", index=False)

    