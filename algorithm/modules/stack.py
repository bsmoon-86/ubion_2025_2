from typing import Any

class FixedStack:
    # 고정길이의 스택을 생성

    class Empty(Exception):
        # 비어있는 스택에서 데이터를 꺼내거나 데이터를 조회할때 호출하는 예외 처리 
        pass
    
    class Full(Exception):
        # 가득 찬 스택에 데이터를 추가하는 경우 호출하는 예외 처리 
        pass

    # 생성자 함수
    def __init__(self, capacity : int = 256) -> None:
        # 스택의 크기
        self.capacity = capacity
        # 스택의 배열 데이터
        self.stk = [None] * self.capacity
        # 스택의 포인터
        self.ptr = 0
    
    # 스택의 길이를 출력하는 함수 
    def __len__(self) -> int:
        return self.ptr

    # 스택에 데이터가 비어있는가? 함수 생성
    def is_empty(self) -> bool:
        # 데이터가 비어있는 조건은 포인터가 0인 경우
        return self.ptr <= 0
    
    # 스택에 데이터가 가득 차있는가? 함수 생성
    def is_full(self) -> bool:
        # 데이터가 가득찬 조건 포인터가 스택의 크기와 같은 경우
        return self.ptr >= self.capacity

    # 데이터를 대입하는 함수를 생성
    def push(self, value : Any) -> None:
        # 스택에 데이터가 가득 차있는가?
        if self.is_full():
            # raise는 예외 처리
            raise FixedStack.Full
        # 가득 차지 않은 경우
        self.stk[self.ptr] = value
        # 대입이 완료한 뒤 포인터를 1 증가 시킨다
        self.ptr += 1
    
    # 데이터를 추출하는 함수 생성
    def pop(self) -> Any:
        # 데이터를 추출할때 데이터가 비어있다면 예외
        if self.is_empty():
            raise FixedStack.Empty
        # 포인터를 1 감소시킨다. 
        self.ptr -= 1
        return self.stk[self.ptr]
        # self.stk의 배열 안에 원소를 None으로 변경하지 않는다. 
        # 포인터의 값을 기준으로 데이터를 확인하기때문에 배열 안에 원소를 변경할 필요가 없다.
        
    # 스택의 전체 데이터를 확인하는 함수
    def dump(self) -> None:
        # 스택에서 바닥부터 꼭대기까지의 데이터를 모두 확인하는 함수 
        if self.is_empty():
            print('스택이 비어있습니다.')
        else:
            print(self.stk[ : self.ptr])
    
    # 스택에 있는 마지막 데이터를 확인 하는 함수 
    def peek(self) -> Any:
        if self.is_empty():
            raise FixedStack.Empty
        # 데이터를 제거하는 부분이 아니기 때문에 포인터의 변경은 없다. 
        return self.stk[self.ptr - 1]

    # 스택을 초기화 하는 함수 
    def clear(self) -> None:
        # 포인터를 기준으로 스택의 데이터를 확인하기 때문에 포인터를 0으로 변경하면 초기화
        self.ptr = 0
    
    # value의 위치를 출력하는 함수 
    def find(self, value : Any) -> int:
        # 스택에서 해당하는 value의 위치를 출력
        # 포인터를 기준으로 역순으로 데이터를 확인 
        for i in range(self.ptr - 1 , -1, -1):
            if self.stk[i] == value:
                # 검색에 성공한다면 인덱스의 값을 출력
                return i
        return -1
    
    # value의 개수를 출력하는 함수 생성
    def count(self, value : Any) -> int:
        cnt = 0
        for i in range(self.ptr):
            if self.stk[i] == value:
                # 데이터가 존재한다면 cnt를 1 증가시킨다. 
                cnt += 1
        return cnt
    
    # in이라는 연산자를 사용하기 위해서 함수 생성 
    def __contains__(self, value : Any) -> int:
        return self.count(value)
        

