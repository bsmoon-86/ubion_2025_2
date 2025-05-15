# 주석
# 설명 -> 코드에 대한 설명 
# 나에게, 나 이외의 사람들에게 코드를 설명

# 변수 생성 
a <- 'test'
a
print(a)
1000 -> b
b
c = TRUE
c
# a, b, c의 데이터의 타입을 확인 
typeof(a)
typeof(b)
typeof(c)
# a 변수에 다른 데이터를 대입 
a <- 10L
typeof(a)

# 백터 데이터 
# c() 함수를 이용하여 생성 
# 일반적으로 변수는 데이터를 1개 저장하는 형태 
# 백터 데이터는 같은 타입의 데이터를 여러개 저장하는 형태
d <- c(1, 2, 3, 4, 5)
e <- c(1, 'test')
print(d)
print(e)
f <- c(TRUE, 'test')
print(f)
g <- c(FALSE, 10)
print(g)
# d라는 백터 데이터에서 2번째 위치의 데이터를 출력 
print(d[2])
'A' == 'a'

# 2차원 데이터 
arr_x = array(
  1:6, 
  dim = c(2, 3)
)
print(arr_x)
arr_y = array(
  1:6, 
  dim=c(5, 5)
)
print(arr_y)
print(arr_y[2:4, ])
print(arr_y[c(2,3,4), ])
# arr_y에서 인덱스 2번과 4번 데이터를 출력하려면?
# 백터데이터 2,4를 생성하여 인덱스 조건에 대입
print(arr_y[c(2,4), ])

# 리스트 데이터 생성 
#  R에서는 리스트 Python에서는 딕셔너리 일반적으로는 json
# 타입이 다른 데이터를 저장이 가능
# 백터데이터에서는 데이터의 위치를 기준으로 필터링 가능
# 리스트 데이터에서는 위치가 아닌 값으로 필터링 가능
list_x = list(
  name = 'test', 
  age = 20, 
  phone = '01012345678'
)
print(list_x)
print(list_x$name)
print(list_x[1])
print(list_x['name'])
# list_x에서 age에 1를 증가
# list_x[key]로 데이터를 추출하면 데이터의 타입이 단일X(차원의 축소X)
list_x['age'] + 1
# list_x$key로 데이터를 추출하면 데이터의 타입이 단일o(차원의 축소o)
list_x$age + 1

typeof(list_x['age'])
typeof(list_x$age)

# 리스트 데이터 안에 value가 1차원 데이터인 경우 -> 2차원 데이터
list_y = list(
  name = c('test', 'test2', 'test3'), 
  age = c(20, 30, 40)
)
list_y
# list_y에서 30이라는 데이터를 추출하려면?
# 30이라는 데이터는 age라는 key 값에 존재
print(list_y$age)
# age에서 2번째 위치에 데이터 
print(list_y$age[2])

# 데이터프레임 생성 
# 2차원 데이터 
# 인덱스(행)과 컬럼(열)에 라벨링을 한 2차원 데이터 형태 
# 각 컬럼 안에 데이터들을 같은 타입을 데이터 구성
df = data.frame(
  name = c('test', 'test2','test3'), 
  age = c(20, 30, 40)
)
df
print(df[2])
# 데이터프레임을 각 컬럼들의 백터데이터의 길이가 같아야된다. 
# 길이가 다르면 에러가 발생 
df2 = data.frame(
  name = c('test', 'test2', 'test3'), 
  age = c(20, 30)
)

# 연산자 
# 산술 연산자 
a <- 10
b <- 3
print(a + b)
print(a - b)
print(a * b)
print(a / b)
# 지수 승 연산자
print(a ^ b)
# 나눈 값에서 나머지 
print(a %% b)
# 나눈 값에서 몫
print(a %/% b)

# 할당 연산자(=, <-, ->) 없는 경우는 데이터가 저장X -> 출력 o
a + b
# 할당 연산자가 존재하는 경우 
# 메모리에 데이터가 변환 -> 출력X
a + b -> z

# 비교 연산자 
# 결과값이 참/거짓의 형태로 출력 
x <- 5
y <- 3
z <- 5

# == : 같다
print(x == y)
print(x == z)
# != : 다르다(같지 않다)
print(x != y)
print(x != z)
# > ,  >=,  < , <=
print(x > y)
print(x >= y)
print(x > z)
print(x >= z)
print(x < y)
print(x <= y)
print(x <= z)
print(x < z)

# 논리 연산자 
# 부정 -> 참을 거짓으로 거짓을 참으로 변경 
print(!TRUE)
print(!(x > y))

# and -> 2개의 논리값(참/거짓)에서 모두 참인 경우에만 참
# 나머지의 경우는 모두 거짓
print(TRUE & TRUE)  # 참
print(TRUE & FALSE)
print(FALSE & TRUE)
print(FALSE & FALSE)

# or -> 2개의 논리값 중 하나만 참이라면 참
# 2개의 논리값이 모두 거짓인 경우에만 거짓
print(TRUE | TRUE)
print(TRUE | FALSE)
print(FALSE | TRUE)
print(FALSE | FALSE)

# 조건문 
# if문 -> 특정 조건에 만족하였을때 코드가 실행
# 기본 문법 if(조건식){ 조건식이 참인경우 실행되는 코드 }
x = 10
# if (10 > 5) -> 조건식이 참
if (x > 5){
  # 참인 경우 실행되는 코드 
  print('x는 5보다 크다.')
}
y = 3
if(y > 5){
  # 3 > 5 -> 거짓
  print('y는 5보다 크다')
  # print()가 실행되지 않는다. 
}
# 거짓일때 실행되는 코드를 작성하려면 -> else 구문을 이용
y = 3
# 3 > 5 -> 거짓
if (y > 5){
  # 참일때 실행되는 코드 
  # 실행X
  print('y는 5보다 크다')
}else{
  # 위의 조건식이 거짓인 경우 실행되는 코드 
  # 실행o
  print('y는 5보다 작거나 같다')
}

# if 조건식이 여러개인 경우 
# 학점 -> A부터 F
# A 학점 -> 100점 만점 기준으로 90점 이상
# B 학점 -> 90점 미만 그리고 80점 이상
# C 학점 -> 80점 미만 그리고고 70점 이상
# F 학점 -> 70점 미만
score = 85
# score가 90점 이상인 경우
if (score >= 90){
  print('A')
}
if (score >= 80 & score < 90){
  print('B')
}
if (score >= 70 & score < 80){
  print('C')
}
if (score < 70){
  print('F')
}

# if ~ else if ~ else
if (score >= 90){
  # score가 90점 이상이라면
  print('A')
}else if(score >= 80){
  # score가 90점 미만인 경우
  # 그리고 score가 80점 이상인 경우
  print('B')
}else if(score >= 70){
  # score가 90점 미만인 경우 
  # and
  # score가 80점 미만인 경우
  # and
  # score가 70점 이상인 경우
  print('C')
}else{
  # score가 90점 미만인 경우
  # score가 80점 미만인 경우
  # score가 70점 미만인 경우
  print('F')
}
# 로그인 상황 재현
# id가 'test'이고 password가 '1234'인 경우 
# 로그인의 성공 조건 -> id와 password가 모두 일치하는 경우
# 그 외의 조건은 모두 로그인 실패
input_id = 'test'
input_pass = '1234'

if (input_id == 'test' & input_pass == '1234' ){
  # input_id가 'test'와 같은 경우
  # input_pass가 '1234'와 같은 경우 
  print('로그인 성공')
}else{
  print('로그인 실패')
}
if(input_id == 'test'){
  if (input_pass == '1234'){
    # input_id가 'test'이고 input_pass가 '1234'인 경우
    print('로그인 성공')
  }else{
    print('로그인 실패')
  }
}else{
  print('로그인 실패')
}

# 문제 
# 특정 숫자가 7의 배수인가?
x = 8845
# 조건식 -> x를 7로 나눠서 나머지가 0이라면
if (x %% 7 == 0){
  # 7의 배수의 조건이 참인 경우 
  print('x는 7의 배수이다')
}else{
  print('x는 7의 배수가 아니다')
}

# which문 
# 벡터데이터(1차원 데이터)에서 특정 데이터가 
# 어느 위치에 존재하는가?
# 존재하지 않다면 0을 출력
names = c('test1', 'test2', 'test3')

names == 'test1'
which(names == 'test1')
which(names != 'test1')
which(names == 'test5')

if (names[1] == 'test1'){
  print(1)
}
if (names[2] == 'test1'){
  print(2)
}
if (names[3] == 'test1'){
  print(3)
}

# 반복문 
# for문 
# 벡터 데이터의 원소의 개수만큼 반복 실행
# for문의 기본형 -> for (변수명 in 벡터데이터){반복실행할 코드}
x = 1:10
for (i in x){
  # x : 1 2 3 4 5 6 7 8 9 10
  # 총 10번 반복 실행하는 for문
  # 반복 실행할때마다 i에 1부터 10까지 한번씩 대입되어 실행
  print(i)
}

ages = c(20, 25, 40, 10)
for (age in ages){
  # 총 4번 반복 실행하는 for문
  # 첫번째 반복 : age 변수에 20이 대입 -> print(20)
  # 두번째 반복 : age 변수에 25가 대입 -> print(25)
  # 세번째 반복 : age 변수에 40이 대입 -> print(40)
  # 네번째 반복 : age 변수에 10이 대입 -> print(10)
  print(age)
}
# 1부터 10까지의 합계 -> 55
1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10
# 반복문 이용해서 1부터 10까지의 합계
# 합계라는 변수를 생성하여 초기값 지정 
result <- 0
for (i in 1:10){
  result <- result + i
}
result
# 1부터 5000까지의 3의 배수의 합계
result <- 0
for (i in 1:5000){
  if (i %% 3 == 0){
    result <- result + i
  }
}
result

# while문 
# while(조건식) : 조건식이 거짓이 될때까지 반복 실행
# 합계 초기값
result <- 0 
# 초기 데이터 필요
a <- 1
# while문 시작
while(a <= 10){
  result <- result + a
  a <- a + 1
}
result
# 1부터 5000까지 3의 배수의 합계
result <- 0
a <- 1
while(a < 5001){
  if (a %% 3 == 0){
    result <- result + a
  }
  a <- a + 1
}
result

result <- 0
a <- 3
while(a <= 5000){
  result <- result + a
  a <- a + 3
}
result

# break : 반복문을 강제로 종료
for (i in 1:10){
  print(i)
  if( i > 5){
    # i가 5보다 큰 경우 실행행
    break
  }
}

a <- 1
while(a <= 10){
  # 증가식
  a <- a + 1
  # if ( a > 5 ){
  #   break
  # }
  print(a)
}

# 1부터 1씩 증가시킨 누적합이 20000이 넘어갈때가 언제인가?
# step1 : 1부터 5000까지 누적합
# step2 : 누적합이 20000이상이라면 조건문을 이용하여 
#         반복문을 강제 종료 ( if (result >= 20000){ break } )
result <- 0
for (i in 1:5000){
  # 1
  if (result >= 20000){
    break
  }
  result <- result + i
  # 2
  # if (result >= 20000){
  #   break
  # }
}
result
i
result2 <- 0 
for (j in 1:200){
  result2 <- result2 + j
}
result2

# 합계 초기값
result_while <- 0
a <- 1

while (TRUE){
  # 1
  result_while <- result_while + a
  # 2
  # if (result_while >= 20000){
  #   break
  # }
  a <- a + 1
  # 3
  if (result_while >= 20000){
    break
  }
}
print(c(a, result_while))




