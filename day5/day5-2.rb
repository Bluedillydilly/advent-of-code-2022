stacks = []

file = File.open("day5-input.txt").each
file.each {|line|
    case line[0..1]
    when "mo" #move stackment
        _, count, _, source, _, dest = line.split().map(&:to_i)
        stacks[dest-1].unshift *stacks[source-1].shift(count)
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
