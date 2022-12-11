require 'set'
subsetCount = 0
File.open("day4-input.txt", "r").each { |line|
    a,b = line.strip().split(",").map{|l| l.split("-").map(&:to_i)}.map{|s| Set.new((s[0]..s[1]))}
    subsetCount += 1 if a <= b || a >= b
}
puts subsetCount