=begin
Find calorie sum of 3 elves with the largest calorie sum.     
=end

best3Sum = [0, 0, 0]
currentSum = 0

fileName = "day1-input.txt"

IO.foreach(fileName){|line| 
    case line
    in "\n"
        if currentSum > best3Sum[0]
            best3Sum.shift
            best3Sum.push(currentSum)
            best3Sum.sort!
        end
        currentSum = 0
    else
        currentSum += line.to_i
    end
}
puts best3Sum.sum