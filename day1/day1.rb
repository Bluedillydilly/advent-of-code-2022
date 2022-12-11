=begin
Find calorie sum of elf with largest calorie sum.     
=end

bestSum = 0
currentSum = 0

fileName = "day1-input.txt"

IO.foreach(fileName){|line| 
    case line
    in "\n"
        puts "Empty line"
        currentSum = 0
    else
        currentSum += line.to_i
    end

    if currentSum > bestSum
        bestSum = currentSum
    end
}
puts bestSum