require 'Matrix'
require 'set'

$height_map = []
location = Vector[0,0]
$goal = Vector[0,0]
$visited = []

$neighbors = [Vector[-1, 0], Vector[0, -1], Vector[0, 1], Vector[1, 0]]

$queue = []

class Configuration
    attr_accessor :x
    attr_accessor :y
    attr_accessor :length
    def initialize(y, x, length)
        @x = x
        @y = y
        @length = length
    end

    def get_successors()
        successors = []
        current_pos = Vector[@y, @x]
        $neighbors.each do |vec|
            new_y, new_x = (current_pos + vec).to_a
            new_config = Configuration.new(new_y, new_x, @length+1)
            if new_y < 0 || new_y >= $height_map.length ||
                    new_x < 0 || new_x >= $height_map[0].length ||
                    ($height_map[new_y][new_x] - $height_map[@y][@x]) > 1 ||
                    $visited.include?(new_config) ||
                    $queue.include?(new_config)
                next
            end
            successors.push(new_config)
        end
        return successors
    end

    def isGoal()
        return @y == $goal[0] && @x == $goal[1] 
    end

    def ==(other)
        return @x == other.x && @y == other.y && @length <= other.length
    end
end


File.open("./day12/day12-input.txt").each {|line|
    $height_map.push(line.strip.split(''))
}
$height_map.length.times do |y|
    $height_map[0].length.times do |x|
        case $height_map[y][x]
        when "S"
            location = [y,x]
            $height_map[y][x] = "a".ord - "a".ord
        when "E"
            $goal = [y,x]
            $height_map[y][x] = "z".ord - "a".ord
        else
            $height_map[y][x] = $height_map[y][x].ord - "a".ord
        end
    end
end
$queue.push(Configuration.new(*location, 0))

current = $queue.shift
while !current.isGoal()
    $queue += current.get_successors()
    $visited.push(current)
    current = $queue.shift
end
puts current.length