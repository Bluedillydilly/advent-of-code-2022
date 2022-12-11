cycles = 1
regX = 1
oneAway = 0
twoAway = 0
queue = []
check_point = [40, 80, 120, 160, 200, 240]

File.open("./day10/day10-input.txt").each {|line|
    instr, value = line.strip.split
    value = value.to_i
    queue.push([instr, value])
}

while queue.length != 0 || oneAway != 0 || twoAway != 0
    if twoAway != 0 # incomplete instr
        oneAway = twoAway
        twoAway = 0
    else
        instr, value = queue.shift
        if instr == "addx"
            twoAway = value
        end
    end

    char = '.'
    if regX <= (cycles % 40) && (cycles % 40) <= (regX + 2) 
        char = '#'
    end
    print char

    regX += oneAway
    oneAway = 0

    if cycles == check_point[0]
        puts
        check_point.shift
    end

    cycles += 1
end