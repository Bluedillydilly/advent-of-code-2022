rows = []

file = File.open("day8-input.txt").each
file.each {|line| # read in
    line = line.strip.split('')
    rows.push(line.map{|l| l.to_i})
}
columns = rows.transpose

$count = columns.length*2 + (rows.length-2)*2 # perimeter all visible

def visibility(seq, range, t)
    count = 0
    range.each do |ti|
        if seq[t] <= seq[ti]
            return false
        end
    end
    $count += 1
    return true
end

(1..rows.length-2).each do |y| # check interior for visible trees
    (1..columns.length-2).each do |x|
        next if visibility(rows[y], (0..x-1), x)            # left check
        next if visibility(rows[y], (x+1..columns.length-1), x) #right check
        next if visibility(columns[x], (0..y-1), y)         #top check
        visibility(columns[x], (y+1..rows.length-1), y)     #bottom check
    end
end

puts $count