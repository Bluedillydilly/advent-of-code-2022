require 'set'
require 'matrix'
$MOVE = {'R'=> Vector[1, 0], 'L'=> Vector[-1,0], 'U'=> Vector[0, 1], 'D'=> Vector[0, -1]}

class End
    attr_accessor :current
    attr_accessor :previous
    attr_accessor :history
    attr_accessor :child
    def initialize()
        @current = Vector[0, 0]
        @previous = Vector[0, 0]
        @history = Set.new()
        @history.add(@current)
        @child = nil
    end

    def dist(other_end)
        return (@current-other_end.current).to_a.map{|e| e.magnitude}.max
    end

    def move(direction)
        @previous = @current
        @current = @current + direction
        @history.add(@current)
        @child.check_up(self)

    end
    
    def check_up(parent)
        if dist(parent) > 1 # check up needed
            diff = parent.current - @current
            move = Vector[0, 0]
            if diff[0] != 0
                move[0] = diff[0]/diff[0].magnitude
            end
            if diff[1] != 0
                move[1] = diff[1]/diff[1].magnitude
            end
            @previous = @current
            @current = @current + move
            @history.add(@current)
            if @child == nil
                return
            end
            @child.check_up(self)
        end
    end
end

$head = End.new()
current = $head
1.times do |_|
    current.child = End.new()
    current = current.child
end

File.open("day9-input.txt").each {|line|
    direction, distance = line.strip.split
    distance = distance.to_i
    distance.times do |_|
        $head.move($MOVE[direction])
    end
}

puts current.history.length