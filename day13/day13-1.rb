indices = []
lefts = []
rights = []

file = File.open("./day13/day13-test.txt").each
file.each {|line|
    if line == "\n"
        next
    end
    lefts.push(eval(line.strip))
    rights.push(eval(file.next.strip))
}
p lefts
p rights

def compare(left, right)
    retval = nil
    left.length.times do |j|
        puts "Compare #{left[j]} vs #{right[j]}"
        case [left[j], right[j]]
        in [Integer => l, Integer => r]
            if l < r
                retval = true
                break
            elsif r < l
                retval = false
                break
            end
        in [Array => ll, Array => rl]
            retval = compare(left[j], right[j])
        in [Array, Integer]
            retval = compare(left[j], [right[j]])
        in [Integer, Array]
            retval = compare([left[j]], right[j])
        else
            puts "ERROR: #{left}, #{right}"
        end

        if retval != nil
            return retval
        end

        if j == left.length - 1
            if left.length < right.length
                return true
            elsif right.length < left.length
                return false
            end
        end
    end

    if left.length == 0 && left.length < right.length
        return true
    elsif left.length == 0 && right.length < left.length
        return false
    end
    
    return retval
end

lefts.length.times do |i|
    p lefts[i]
    p rights[i]
    result = compare(lefts[i], rights[i])
    p result
    if result == true
        indices.push(i+1)
    end
    puts "#{result ? "CORRECT" : "INCORRECT"} INDICE #{i+1}\n\n"
end

p indices.sum