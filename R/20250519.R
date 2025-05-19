# 패키지 설치 
install.packages('dplyr')
library(dplyr)

# spss 파일을 로드하기 위한 패키지 설치 
# .sav파일을 로드하기 기능이 따로 존재
install.packages('foreign')
library(foreign)

# 외부의 데이터 파일을 로드 
# 현재 디렉토리 -> 상위 폴더 이동(../)
# -> csv 하위 폴더(csv/) -> Koweps.sav
read.spss("../csv/Koweps.sav", to.data.frame = T) -> welfare

# 파일의 구조 확인
View(welfare)

# codebook을 참고하여 데이터의 컬럼의 이름을 변경
# 컬럼의 이름을 변경하는 함수는 rename()
# rename( 데이터프레임명, 새 컬럼명 =  기준 컬럼 이름 )
welfare %>% rename(
  gender = h10_g3, 
  birth = h10_g4, 
  code_job = h10_eco9, 
  income = p1002_8aq1, 
  loc = h10_reg7
) %>% select(gender, birth, code_job, income, loc) -> df

# 데이터프레임의 정보 확인 
str(df)
# 통계 정보 확인 
summary(df)

# 결측치의 개수를 확인 
# is -> 존재 유무 ,  na -> 결측치 
# is.na() : 결측치인 경우 TRUE, 아니면 FALSE
# table() : 데이터의 빈도수 확인
table(
  is.na(df)
)
# 각 컬럼별 결측치의 개수
table(is.na(df$gender))
table(is.na(df$birth))
table(is.na(df$code_job))
table(is.na(df$income))
table(is.na(df$loc))

# 성별을 male, female로 변경 
# ifelse(조건식, 참인경우 결과, 거짓인 경우 결과)
ifelse(df$gender == 1, 'male', 'female') -> df$gender
table(df$gender)

# 남녀 간의 평균의 임금이 얼마나 차이가 날것인가?
# 특정 컬럼을 선택 (gender, income) -> select()
# 성별과 임금에 결측치를 제외(0과 9999 제외) -> filter()
# 성별을 기준으로 데이터프레임을 그룹화 -> group_by()
# 임금의 그룹화 연산(평균)을 구해서 새로운 데이터프레임 -> summarise()
df %>% 
  select(gender, income) %>% 
  # income에 데이터에서 결측치가 아니라면 !is.na(income)
  # filter(!is.na(income)) %>% 
  # filter(income != 0) %>% 
  # filter(income != 9999)
  filter(!is.na(income) & income != 0 & income != 9999 ) %>% 
  # 그룹화 group_by(그룹화할 컬럼 이름)
  group_by(gender) %>% 
  # summarise( 컬럼의 이름 =  연산 데이터)
  summarise( mean_income = mean(income) )







