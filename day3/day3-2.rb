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

file = File.open("day3-input.txt", "r").each
file.each {|line|
    set1 = Set.new(line.strip().split(''))
    set2 = Set.new(file.next.strip().split(''))
    set3 = Set.new(file.next.strip().split(''))
    itemSum += prior((set1 & set2 & set3).to_a()[0])
}
puts itemSum