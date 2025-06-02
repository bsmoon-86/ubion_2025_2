import os
from glob import glob
import pandas as pd

def dir_load_vari( file_path, file_tail = '*.*', engine = 'cp949'):
    # file_path와 file_tail 입력이 되는 
    # 인자값을 이용하여 파일의 목록을 생성
    # file_path = "../../csv/num_3/*.*"
    # file_path 매개변수 -> ../../csv/num_3, ../../csv/num_3/
    # file_tail -> csv -> "*." + file_tail -> *.csv
    # 만약에 file_tail이 *.*이 아니라면(같지 않다)?
    if file_tail != '*.*':
        file_tail = "*." + file_tail
    # glob()를 이용하여 파일의 목록을 로드 
    file_list = glob(file_path + '/' + file_tail)

    # 반복문이 몇번 반복했는가를 알기 위해 숫자 0을 변수에 저장
    cnt = 0
    for file in file_list:
        # file를 경로와 파일의 이름으로 나눠준다. 
        path, name = os.path.split(file)
        # name = os.path.split(file)[1]
        # name에서 이름과 확장자로 나눠준다. 
        head, tail = os.path.splitext(name)
        # head -> 전역변수의 이름 
        # tail -> 확장자로 read함수를 지정하기 위해 사용
        if tail == '.csv':
            # globals()[head] = pd.read_csv(file, encoding = engine)
            try:
                df = pd.read_csv(file, encoding='utf-8')
            except:
                df = pd.read_csv(file, encoding=engine)
        elif tail == '.tsv':
            try:
                df = pd.read_csv(file, sep='\t')
            except:
                df = pd.read_csv(file, sep='\t', encoding=engine)
        elif tail == '.json':
            try:
                df = pd.read_json(file)
            except:
                df = pd.read_json(file, encoding=engine)
        elif tail == '.xml':
            try:
                df = pd.read_xml(file)
            except:
                df = pd.read_xml(file, encoding=engine)
        elif tail in ['.xlsx', '.xls']:
            df = pd.read_excel(file)
        try : 
            # head를 이용하여 전역변수를 생성하고 df의 복사본을 대입
            globals()[head] = df.copy()
            # 전역변수가 생성이 되었기 때문에 cnt를 1 증가시킨다. 
            cnt += 1
            # 전역변수가 생성되었다는것을 print()를 이용하여 출력 
            print(f"{cnt}번째 전역 변수가 생성 : {head}")
        except:
            print(f"{tail} 확장자는 지원하기 않은 확장자입니다.")
    # 함수를 종료하기 위해 전역변수가 생성된 횟수인 cnt 되돌려준다. 
    return cnt
    
# 특정 경로에 존재하는 데이터 파일을 로드하여 하나의 데이터프레임으로 생성해주는 함수
# 매개변수 3개 -> 파일의 경로, 파일의 확장자, 인코딩엔진( 기본값 : utf-8 )
def dir_load_df(file_path, file_tail, engine = 'utf-8'):
    # file_path에 마지막이 '/'없으면 문제가 발생 -> '/' 추가
    # file_path = file_path + '/'
    file_path += '/'
    # file_path를 기준으로 파일의 목록을 생성 
    file_list = os.listdir(file_path)
    file_list.sort()
    result = pd.DataFrame()
    # file_tail에 맞는 파일들을 추출 
    new_list = []
    for file in file_list:
        if file.endswith(file_tail):
            new_list.append(file)
    # new_list를 이용하여 파일을 로드하고 result 누적 행 결합
    for file2 in new_list:
        # file_tail에 따라서 read_함수를 변경 
        if file_tail == 'csv':
            df = pd.read_csv(file_path + file2, encoding=engine)
        elif file_tail == 'json':
            df = pd.read_json(file_path + file2, encoding=engine)
        elif file_tail == 'xml':
            df = pd.read_xml(file_path + file2, encoding=engine)
        # elif (file_tail == 'xlsx') | (file_tail == 'xls'):
        elif file_tail in ['xlsx', 'xls']:
            df = pd.read_excel(file_path + file2)
        else:
            print("파일의 확장자 입력이 잘못되었습니다.(csv, json, xml, excel 사용가능)")
            return ""
        # result에 누적 행 결합
        result = pd.concat( [result, df] )
        print(
            f"{file2} 데이터 행결합 완료"
        )
    # result에서 인덱스를 초기화하고 기존의 인덱스는 제거 
    result.reset_index(drop=True, inplace=True)
    return result


# dir_load_vari()아 dir_load_df()함수를 호출하는 새로운 함수를 생성
# 매개변수  -> dir_load_xxx() 함수에서 사용되는 매개변수의 값들을 모두 생성
# 둘중에 어떤 함수를 호출할 것인가를 지정하는 매개변수 하나 필요
def dir_load(file_path, file_tail = '*.*', engine = 'utf-8', selected = 0):
    # selected가 0이라면?
    if selected == 0:
        result = dir_load_vari(file_path, file_tail, engine)
    else : 
        if file_tail == '*.*':
            file_tail = 'csv'
        result = dir_load_df(file_path, file_tail, engine)
    return result


print(dir_load( r'C:\ubion_2025_2\csv\num_3' ))   # 반복횟수 : 5

print(dir_load(r'C:\ubion_2025_2\csv\2021', selected=1)) # 결합된 데이터프레임