'''
문제 5.
표준 입력으로 물품 가격 여러 개가 문자열 한 줄로 입력되고, 각 가격은 ;(세미콜론)으로 구분되어 있습니다.
입력된 가격을 높은 가격순으로 출력하는 프로그램을 만드세요.
# 입력 예시: 300000;20000;10000
'''
1
prices = input('물품 가격을 입력하세요: ')

# # 아래에 코드를 작성해 주세요.

# charlist = list(prices)
# charlist.append(";")

# llist = []
# semilist = []

# a = ""
# while len(charlist) != 0 :
#     if charlist[0] != ";" :
#         a = int(a + charlist.pop(0))
    
#     else : 
#         llist.append(a)
#         semilist.append(charlist.pop(0))
#         a =""

# print(llist)
      
makes = prices.split(';')
print(makes)
boxes = []
for make in makes:
    boxes.append(int(make))

boxes.sort(reverse = True)
    # sort를 쓰면 원본을 바꿔 정렬해주고
    # sorted는 원본은 변형하지 않은 채, 출력의 순서만 변경함

for box in boxes : 
    print(box)