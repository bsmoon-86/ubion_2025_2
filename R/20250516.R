# 반복문 문제 
# 2개의 주사위가 존재한다. 
# 주사위를 굴려서 주사위의 합이 10인 
# 모든 경우의 수를 출력하시오
# 2개의 주사위의 경우의 수 : 36개
# 1번째 -> 4, 6
# 2번째 -> 5, 5
# 3번째 -> 6, 4

# 첫번째 주사위의 경우의 수를 반복문 작성
for (i in 1:6){
  # 두번째 주사위의 경우의 수를 반복문 작성
  for (j in 1:6){
    # 반복실행되는 코드(36)
    # 두개의 주사위의 합(i + j)이 10인 -> 조건식
    if (i + j == 10){
      print(c(i, j))
    }
  }
  # 반복실행되는 코드 (6)
}
# 첫번째 반복 : i = 1, j = 1
# 두번째 반복 : i = 1, j = 2
# 세번째 반복 : i = 1, j = 3
# ....
# 일곱번째 반복 : i = 2, j = 1

# while문 작성
# 다중 while문
# 초기값(2개)
i <- 1
j <- 1

# 첫번째 주사위의 경우의 수 
while (i < 7){
  ## 1
  # j <- 1
  # 두번째 주사위의 경우의 수 
  while (j < 7){
    # 두개의 주사위의 합이 10이라면
    if (i + j == 10){
      print(c(i, j))
    }
    # j를 1씩 증가시킨다. 
    j <- j + 1
  }
  ## 2
  j <- 1
  # i를 1씩 증가시킨다.
  i <- i + 1
}

# 함수 
# 특정한 행동하는 코드 
# 입력 값을 받아서 연산을 한 뒤 되돌려준다. 

# 매개변수와 인자가 존재하지 않는 경우 
func_1 <-  function(){
  print('Hello R')
}

# 함수 호출
func_1()

# 매개변수가 존재하지 않는 함수에 인자 입력
# 에러 발생 : 입력값을 저장한 공간이 존재하지 않는다. 
func_1('a')

# 매개변수 존재하는 함수 생성
func_2 <- function(x, y){
  # 매개변수는 2개
  return (x + y)
}

# func_2()함수를 호출 -> 매개변수 2개 -> 인자 2개
func_2(3, 4)
func_2(10, 2)

func_3 <- function(x, y){
  return (x ^ y)
}

func_3(10, 2)
func_3(2, 10)
# func_3에 x에는 2를 대입 y에는 10를 대입하겠다
func_3(y = 10, x = 2)

# 매개변수에 기본값이 존재하는 함수 
func_4 <- function(x, y = 3, z = 2){
  return ( (x + y) ^ z )
}

func_4(1)
func_4(1, 2)
func_4(2, 3, 3)
func_4(2, z = 3)

# 인자의 개수가 가변인 경우 
func_5 <- function(...){
  print(c(...))
}

func_5(1, 2, 3, 4, 5)
func_5(1, 6, 3)
func_5(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# 합계를 구하는 함수 생성
# 인자가 가변인 경우 
func_sum <- function(...){
  # 누적합을 할수 있는 데이터를 생성 
  result <- 0
  # ... 데이터를 반복 실행하여 result에 누적합
  for (i in c(...)){
    result <- result + i
  }
  # 누적합이 된 결과값을 되돌려준다. 
  return (result)
}
func_sum(1, 2, 3, 4, 5)
func_sum(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
func_sum(10, 3)
# 인자를 벡터데이터로 입력 하는 경우
func_sum_2 <- function(x){
  # x에는 벡터데이터가 입력 가정 
  result <- 0
  for (i in x){
    result <- result + i
  }
  return (result)
}
func_sum_2( c(1, 2, 3, 4, 5) )
# 에러 발생 
func_sum_2(1, 2, 3)

# 함수 생성
# 매개변수 2개 사용
# 시작값, 종료값
func_sum_3 <- function(start, end){
  result <- 0
  for (i in start:end){
    result <- result + i
  }
  return (result)
}
func_sum_3(1, 10)
func_sum_3(10, 1)

func_sum_4 <- function(start, end){
  result <- 0
  if (start < end){
    while (start <= end){
      result <- start + result
      start <- start + 1
    }
  }else{
    while (end <= start){
      result <- result + end
      end <- end + 1
    }
  }
  return (result)
}
func_sum_4(1, 10)
func_sum_4(10, 1)

func_sum_5 <- function(start, end){
  result <- 0
  if (start < end){
    s <- start
    e <- end
  }else{
    s <- end
    e <- start
  }
  while (s <= e){
    result <- result + s
    s <- s + 1
  }
  return (result)
}
func_sum_5(1, 10)
func_sum_5(10, 1)

# 함수를 생성 
# 인자의 개수가 가변 
# 해당하는 인자들의 평균값을 출력하는 함수 
func_mean <- function(...){
  # 합계를 구하기 위한 초기 값 0
  sum_data <- 0
  # 개수를 확인하기 위한 변수 생성 0
  cnt <- 0
  # 반복문을 생성
  for (i in c(...)){
    # 누적합
    sum_data <- sum_data + i
    # 반복 실행할때마다 개수를 1씩 증가
    cnt <- cnt + 1
  }
  # 누적합과 개수를 나눠준 값을 되돌려준다. 
  return (sum_data / cnt)
}
func_mean(2, 4, 6, 8, 10)

# 커스텀 연산자 
"%s%" <- function(x, y){
  return ( (x+y) ^ y )
}
5 %s% 2
func_6 <- function(x,y){
  return ( (x+y) ^ y )
}
func_6(5, 2)

# 데이터프레임
# 데이터의 분석에서 가장 많이 사용되는 
# 2차원 데이터의 형태
names <- c('test', 'test2', 'test3')
grade <- c(1, 2, 2)
# 벡터데이터를 이용해서 데이터프레임을 생성
# 같은 길이의 벡터데이터를 이용
student <- data.frame(names, grade)
student
typeof(student)

midturm <- c(70, 80, 90)
final <- c(100, 90, 95)
score <- cbind(midturm, final)
score
typeof(score)

# 벡터데이터 생성
gender <- c('F', 'F', 'M')
# 데이터프레임, 행렬, 벡터 데이터를 결합 
data.frame( student, score, gender ) -> students

# 특정 컬럼의 데이터를 확인 
# 데이터프레임명$컬럼명
students





