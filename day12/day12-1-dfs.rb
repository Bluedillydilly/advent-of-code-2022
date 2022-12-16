require 'set'

height_map = []
start = [0,0]
goal = [0,0]
visited = []
point_map = {}

File.open("./day12/day12-input.txt").each {|line|
    height_map.push(line.strip.split(''))
}
height_map.length.times do |y|
    height_map[0].length.times do |x|
        case height_map[y][x]
        when "S"
            start = [y,x]
            height_map[y][x] = "a".ord - "a".ord
        when "E"
            goal = [y,x]
            height_map[y][x] = "z".ord - "a".ord
        else
            height_map[y][x] = height_map[y][x].ord - "a".ord
        end
    end
end
height_map.length.times do |y|
    height_map[0].length.times do |x|
        current = height_map[y][x]
        neighbors = []
        if y > 0 && (height_map[y-1][x] - current) <= 1 # top valid
            neighbors.push([y-1,x])
        end
        if x > 0 && (height_map[y][x-1] - current) <= 1 # left valid
            neighbors.push([y,x-1])
        end
        if y < (height_map.length-1) && (height_map[y+1][x] - current) <= 1 # bottom valid
            neighbors.push([y+1,x])
        end
        if x < (height_map[0].length-1) && (height_map[y][x+1] - current) <= 1 # right valid
            neighbors.push([y,x+1])
        end
        point_map[[y,x]] = neighbors
    end
end

def reconstruct_path(cameFrom, current)
    total_path = [current]
    while cameFrom.key?(current)
        current = cameFrom[current]
        total_path.push(current)
    end
    return total_path
end

openSet = Set.new([start])
cameFrom = {}

gScore = {}
gScore.default = 10000000
gScore[start] = 0

while !openSet.empty?()
    current = openSet.to_a[0]
    if current == goal
        p reconstruct_path(cameFrom, current).length-1
        break
    end

    openSet.delete(current)
    point_map[current].each do |neigh|
        if (gScore[current] + 1) < gScore[neigh]
            cameFrom[neigh] = current
            gScore[neigh] = gScore[current] + 1
            if !openSet.include?(neigh)
                openSet.add(neigh)
            end
        end
    end
end