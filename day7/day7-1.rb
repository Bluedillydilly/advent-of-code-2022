class Node
    attr_accessor :files
    attr_accessor :name
    attr_accessor :value
    attr_accessor :children
    def initialize(name, parent=false, value=0)
        @name = name
        @parent = parent
        @children = []
        @files = []
        @value = value.to_i
    end

    def addNewChild(name)
        @children.push(Node.new(name, self))
    end

    def ==(other)
        return @name == other.name
    end

    def str()
        if @name == '/'
            return @name
        end
        return @parent.str + @name + "/"
    end

    def subdir(name)
        temp = Node.new(name)
        if @children.include?(temp)
            return @children.detect {|child| child == temp}
        end
        return self
    end

    def supdir()
        if @name == '/'
            return self
        end
        return @parent
    end

    def score
        if @value == 0 # node is a folder
            return  @files.map{|file| file.score}.sum + @children.map{|child| child.score}.sum
        end
        return @value
    end
end

root = Node.new('/')
current_dir = root

file = File.open("day7-test.txt").each
file.each {|line|
    line = line.strip.split
    if line.first == "$" # commands
        puts "Command: #{line[1]}, #{line[2..]}" 
        case line[1..]
        in ["cd", ".."]
            puts "Moving to parent dir"
            current_dir = current_dir.supdir
        in ["cd", "/"]
            puts "Moving to base dir"
            current_dir = root
        in ["cd", x]
            puts "Moving to subdir '#{x}'"
            current_dir = current_dir.subdir(x)
        in ["ls"]
            puts "ls"
        end 
        puts "Current at #{current_dir.str}"
    else # ls results
        case line
        in ["dir", dir_name] 
            puts "new dir: '#{dir_name}'"
            current_dir.addNewChild(dir_name)
        in [String => size, String => file_name]
            puts "New file #{file_name} (#{size})"
            current_dir.files.push(Node.new(file_name, false, size))
        end
    end

    puts
}
queue = [root]
total = 0
while queue.length != 0 do
    current = queue.shift
    queue.push(*current.children)
    puts "Checking folder '#{current.str}'..."
    s = current.score
    puts "folder size #{s}"
    if s < 100000
        puts "folder valid"
        total += s
    end
end
puts total