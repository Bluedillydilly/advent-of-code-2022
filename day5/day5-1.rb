stacks = []

file = File.open("day5-input.txt").each
file.each {|line|
    case line[0..1]
    when "mo" #move stackment
        parts = line.split()
        parts[1].to_i.times do |i|
            stacks[parts[5].to_i-1].unshift stacks[parts[3].to_i-1].shift
        end
    when " 1"
        file.next
        stacks = stacks.transpose
        stacks.each do |stack|
            while stack[0] == " "
                stack.shift
            end
        end
    else #stack def
        stacks.append(((line.length+1)/4).times.collect{|x| 1 + x*4}.map{
            |i| line[i]
        })
    end
}
puts stacks.map{|s| s.first}.join('')
