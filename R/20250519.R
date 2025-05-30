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
  summarise( mean_income = mean(income) ) -> gender_income
# 그래프 시각화
ggplot(
  gender_income, 
  aes(
    x = gender, 
    y = mean_income
  )
) + geom_col()

# 나이 컬럼을 생성 
# 현재 년도(2015) - birth 

# base
# 데이터프레임명$age <- 2015 - 데이터프레임명$birth
# dplyr 패키지
# mutate() 함수를 이용하여 컬럼을 추가
# 나이별 평균 임금이 어떻게 되는가?
# 나이라는 컬럼을 생성 (mutate())
# 특정 컬럼을 선택 (select())
# 임금이 0, 9999, 결측치인 경우 제외 (filter())
# 나이를 기준으로 그룹 (group_by())
# 그룹화 연산 (summarise())
df %>% 
  # mutate(데이터프레임명, 컬럼의 이름 = 1차원 데이터)
  mutate(age = 2015 - birth + 1) %>% 
  # 특정 컬럼을 선택 
  select(age, income) %>% 
  # income에 결측치 제외, 0과 9999도 제외
  filter(!is.na(income) & !income %in% c(0, 9999) ) %>% 
  # 나이를 기준으로 그룹화
  group_by(age) %>% 
  summarise(mean_income = mean(income)) -> age_income

# 그래프 (막대그래프)
ggplot(
  age_income, 
  aes(
    x = age, 
    y = mean_income
  )
) + geom_col()


ggplot(
  age_income, 
  aes(
    x = age, 
    y = mean_income
  )
) + geom_line()

# age_income에서 평균 임금이 높은 상위 5개 출력 
# age를 기준으로 내림차순 정렬
# 상위의 5개의 데이터를 선택한다. 
age_income %>% 
  arrange(-mean_income) %>% 
  head(5)

# 연령대 별 평균 임금 
# 나이 컬럼(age)을 생성 -> 2015 - birth + 1
# 연령대 컬럼(ageg)을 생성 -> 
#   20세 이상부터 40세 미만 : 'young'
#   40세 이상부터 60세 미만 : 'middle'
#   60세 이상 : 'old'
# (ifelse() 함수를 이용)
# 임금 결측치와 0, 9999를 제외
# 연령대를 기준으로 그룹화
# 그룹화 연산은 임금의 평균균
df %>% 
  mutate(age = 2015 - birth + 1) %>% 
  mutate(ageg = ifelse(
      20 <= age & 40 > age, 
      'young',
      ifelse(
        60 > age, 
        'middle', 
        'old'
      )
    )
  ) %>% 
  filter(!is.na(income) & !income %in% c(0, 9999)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income)) -> ageg_income

# x축의 순서를 고정값을 지정정
ggplot(ageg_income, 
       aes(x = ageg, 
           y = mean_income)
      ) + geom_col() + scale_x_discrete(
        limits = c('young', 'middle', 'old')
      )


# 조인 결합 
# 특정한 조건에 맞춰서 열을 결합 
df_1 <- data.frame(
  id = 1:3, 
  score = c(70, 80, 90)
)
df_1
df_2 <- data.frame(
  id = 2:5, 
  weight = c(40, 50, 60, 70)
)
df_2
# 조인 결합 -> left, right, inner, full
# 교집합 (2개의 데이터프레임이 모두 가지고 있는)
inner_join(df_1, df_2, by='id')
# 왼쪽 기준 
left_join(df_1, df_2, by='id')
right_join(df_1, df_2, by='id')
full_join(df_1, df_2, by='id')

df_3 = data.frame(
  id = c(2, 2 ,5, 5, 5), 
  loc = c('a', 'b', 'c', 'd', 'e')
)
left_join(df_3, df_2, by='id')


# df에 code_job 컬럼과 codebook에 있는 직업 이름을 결합
# codebook.xlsx 파일을 로드 
install.packages('readxl')
library(readxl)
read_excel("../csv/Koweps_Codebook.xlsx", sheet = 2) -> code_book

# 조인결합 
# df를 기준 // 교집합 --> df에 code_job에 데이터는 code_book에 존재

df %>% 
  filter(!is.na(code_job)) %>% 
  filter(income == 0)

# code_job이 결측치인 데이터는 제외
# inner_join 사용
inner_join(df, code_book, by='code_job') -> total_df

View(total_df)

# 과연 어떤 직종이 돈을 가장 많이 버는가?
# 상위의 10개 직업을 확인

# 임금이 결측치인 경우 제외(filter)
# 직업을 기준으로 그룹화 (group_by)
# 그룹화 연산은 임금의 평균 (summarise)
# 평균 임금에서 내림차순 정렬 (arrange)
# 상위 10개를 필터(head)
total_df %>% 
  filter(!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(-mean_income) %>% 
  head(10)

# 성별이 남자인 데이터에서 직업별 평균 임금이 높은 상위 5개
total_df %>% 
  filter(gender == 'female' & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), cnt = n()) %>% 
  filter(cnt >= 10) %>% 
  arrange(-mean_income) %>% 
  head(5)
# 성별이 여자인 데이터에서 직업별 평균 임금이 높은 상위 5개













