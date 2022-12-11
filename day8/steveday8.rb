# TODO: Both Part 1 & Part 2

input = """30373
25512
65332
33549
35390
"""

forest = input.split(/\n/).map!{|i| i.split('').map(&:to_i) }

forest_height = forest.length
forest_width = forest[0].length
visible = 0
forest_height.times do |i|
  forest_width.times do |it2|
    # print "visible #{visible} : #{forest[i][it2]}\n"
    if i == 0 || it2 == 0 || it2 == forest_width - 1 || i == forest_height - 1
      visible += 1
      next
    end
    if forest[i][0..it2].max < forest[i][it2] || forest[i][it2..forest_width-1].max < forest[i][it2]
      visible += 1
      next
    end

    visible_above = true
    visible_below = true
    forest_height.times do |i3|
      break if i3 > i
      if forest[i3][it2] > forest[i][it2]
        visible_above = false
        break
      end
    end
    (forest_height - 1).downto(0) do |i3|
      break if i3 < i
      if forest[i3][it2] > forest[i][it2]
        visible_below = false
        break
      end
    end
    visible += 1 if visible_below || visible_above
    puts "#{i} #{it2}" if  visible_below || visible_above
  end
end
puts visible