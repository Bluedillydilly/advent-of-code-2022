=begin
       
=end

outcome = [3, 0, 6]
shape = [1, 2, 3]
fileName = "day2-input.txt"
score = 0

IO.foreach(fileName){|line|
    a,z = line.strip.split
    rs = shape[z.ord - 'X'.ord] # shape score
    rs += outcome.rotate(-1*(z.ord - 'X'.ord))[a.ord - 'A'.ord] # outcome score
    score += rs
}
puts "Final score: #{score}"