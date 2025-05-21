# 변수 생성
test_data = 'module_test'

# 함수 생성 
# 매개변수 2개 두개의 사이값의 누적합
def custom_sum(_start, _end):
    # _start와 _end 중 작은 값은 시작값
    start = min(_start, _end)
    # _start와 _end 중 큰 값에 + 1은 종료값
    end = max(_start, _end) + 1
    result = 0
    for i in range(start, end, 1):
        result += i
    return result

# 계산기 class
class Calcurate:
    # 생성자 함수에서 데이터를 2개를 생성 
    def __init__(self, input_a, input_b):
        self.a = input_a
        self.b = input_b

    # self.a와 self.b를 더해주는 함수 생성 
    def add(self):
        result = self.a + self.b
        # self.a와 self.b 데이터의 변화는 없다
        return result
    
    # self.a와 self.b를 빼주는 함수 생성
    def sub(self):
        result = self.a -self.b
        return result

    def multi(self):
        result = self.a * self.b
        return result
    
    def dev(self):
        result = self.a / self.b
        return result
