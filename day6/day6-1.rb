require 'set'
buffer = File.read("day6-input.txt").strip.split('')
markerSize = 14
(buffer.length-markerSize+1).times do |i|
    if Set.new(buffer.slice(i,markerSize)).length == markerSize
        puts i+markerSize
        break
    end
end