import pandas as pd
import time
from bs4 import BeautifulSoup as bs
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

# ticker 입력하는 부분 
ticker = input('ticker을 입력하시오 : ')


# 웹 브라우져를 오픈
driver = webdriver.Chrome()

time.sleep(1)

# 야후파이낸스 접속
driver.get("http://finance.yahoo.com/")

time.sleep(5)

# 웹 브라우져 전체화면 모드 
driver.fullscreen_window()
# 상단 검색어창을 선택
element = driver.find_element(By.ID, 'ybar-sbq')
element.send_keys(ticker)
# 검색어창에 키보드의 특수 이벤트 (ENTER) 입력
element.send_keys(Keys.ENTER)

time.sleep(2)

# 좌측 사이드바의 메뉴들을 모두 선택
elements = driver.find_elements(By.CSS_SELECTOR, '.item.yf-x2pyjv')
# 좌측 사이드바 메뉴 중 2번째 메뉴를 클릭 -> news
elements[1].click()

time.sleep(2)

soup = bs(driver.page_source, 'html.parser')

# 웹 브라우져 종료
driver.close()

ul_data = soup.find(
    'ul', attrs={
        'class' : 'stream-items yf-1drgw5l'
    }
)

a_list = ul_data.find_all('a')

_list = []
for i in a_list:
    href = i['href']
    if (href not in _list) and (href.startswith('https://finance')):
        _list.append(href)

h3_list = ul_data.find_all('h3')

headline = []
for h3_data in h3_list:
    headline.append( h3_data.get_text() )

df = pd.DataFrame( 
    { 
        'headline': headline, 
        'url' : _list
    } 
)

df.to_csv(f'./data/{ticker}_news.csv', index=False)