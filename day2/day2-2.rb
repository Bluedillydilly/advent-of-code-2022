=begin
       
=end
values = [2,1,3]
outcome = {"X" => 0, "Y" => 3, "Z" => 6}

fileName = "day2-input.txt"
score = 0

IO.foreach(fileName){|line|
    opp,out = line.strip.split
    puts "Opp picked: #{opp}, outcome: #{out}"
    os = outcome[out] # outcome score
    ds = os/3 - 1
    ss = values.rotate(-1*(opp.ord - 'A'.ord)).rotate(-1*ds)[1]
    puts "outcome: #{os}, shape: #{ss}"
    score += os + ss
}
puts "Final score: #{score}"