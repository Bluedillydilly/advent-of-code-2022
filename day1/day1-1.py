'''
Find calorie sum of elf with largest calorie sum.     
'''

bestSum = 0
currentSum = 0

fileName = "day1-input.txt"

for line in open(fileName): 
    match line.strip():
        case "\n" | '':
            print("Empty line")
            currentSum = 0
        case food:
            currentSum += int(food)
            
    if currentSum > bestSum:
        bestSum = currentSum
print(bestSum)