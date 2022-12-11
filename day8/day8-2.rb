rows = []

file = File.open("day8-input.txt").each
file.each {|line| # read in
    line = line.strip.split('')
    rows.push(line.map{|l| l.to_i})
}
columns = rows.transpose

best_scenic_score = 1

def visibility(seq, range, home)
    count = 0
    range.each do |ti|
        count += 1
        if seq[home] <= seq[ti]
            break
        end
    end
    return count
end

(0..rows.length-1).each do |y| # check interior for visible trees
    (0..columns.length-1).each do |x|
        scenic_score = 1
        scenic_score *= visibility(rows[y], (x-1).downto(0), x)            # left check
        scenic_score *= visibility(rows[y], (x+1..columns.length-1), x) #right check
        scenic_score *= visibility(columns[x], (y-1).downto(0), y)         #top check
        scenic_score *= visibility(columns[x], (y+1..rows.length-1), y)     #bottom check
        best_scenic_score = scenic_score if scenic_score > best_scenic_score
    end
end

puts best_scenic_score