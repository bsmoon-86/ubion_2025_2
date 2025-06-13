import pandas as pd
import time 
from bs4 import BeautifulSoup as bs
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys


# 기본 주소를 변수에 대입
base_url = 'https://dart.fss.or.kr/'

def create_df(web):
    # 해당 페이지의 페이지소스를 이용해서 데이터프레임 생성
    # 페이지소스를 문자화
    html_data = str(web.page_source)
    # 문자화된 페이지 소스를 read_html() 인자로 사용
    # 결과의 첫번째 데이터프레임을 변수에 대입
    df = pd.read_html(html_data)[0]
    # 해당 페이지소스를 BeautifulSoup으로 파싱 
    soup = bs(web.page_source, 'html.parser')
    # soup에서 tbody 태그 중 id가 tbody인 태그를 선택 
    tbody_data = soup.find(
        'tbody', attrs={
            'id' : 'tbody'
        }
    )
    tr_list = tbody_data.find_all('tr')
    url_list = []
    for tr_data in tr_list:
        url = base_url + tr_data.find_all('a')[1]['href']
        url_list.append(url)
    # df에 url_list 새로운 컬럼(url)에 대입 
    df['url'] = url_list
    # 데이터프레임을 리턴
    return df
    
def dart_save(_name):
    driver = webdriver.Chrome()
    driver.get(base_url)
    time.sleep(1)
    input_tag = driver.find_element(By.ID , 'textCrpNm2')
    input_tag.send_keys(_name)
    input_tag.send_keys(Keys.ENTER)
    time.sleep(1)
    result = create_df(driver)
    result.to_csv(f"{_name}.csv", index=False)
    print(f"{_name}.csv 파일 생성 완료")
    driver.close()


if __name__ == "__main__":
    # dart.py 파일을 직접 실행했을때 실행되는 부분 
    name = input("검색할 종목의 이름을 입력하시오 : ")
    dart_save(name)