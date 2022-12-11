require 'set'
def prior(item)
    item = item.ord
    if (item < 'Z'.ord + 1) # UPPERCASE LETTER
        return item - 'A'.ord + 27
    else # LOWERCASE LETTER
        return item - 'a'.ord + 1
    end
end

itemSum = 0

File.foreach("day3-input.txt") {|line|
    line = line.strip()
    first, second = [line[0, line.size/2], line[line.size/2, line.size]]
    itemSum += prior((Set.new(first.split('')) & Set.new(second.split(''))).to_a()[0])
}
puts itemSum