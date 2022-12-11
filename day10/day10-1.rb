cycles = 1
regX = 1
oneAway = 0
twoAway = 0
queue = []
strength = 0
check_point = [20, 60, 100, 140, 180, 220]

File.open("./day10/day10-input.txt").each {|line|
    instr, value = line.strip.split
    value = value.to_i
    queue.push([instr, value])
}

while queue.length != 0 || oneAway != 0 || twoAway != 0
    puts "start of cycle #{cycles}: #{regX}"
    if cycles == check_point[0]
        puts "--------------------------CHECK POINT #{cycles}: #{cycles * regX}"
        strength += cycles * regX
        check_point.shift
    end
    if twoAway != 0 # incomplete instr
        oneAway = twoAway
        twoAway = 0
    else
        instr, value = queue.shift
        
        if instr == "addx"
            twoAway = value
        end
    end

    regX += oneAway
    oneAway = 0
    puts "end of cycle #{cycles}: #{regX}"
    puts
    
    cycles += 1
end

puts "Total signal strength: #{strength}"