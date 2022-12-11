class Folder
    attr_accessor :files
    attr_accessor :name
    attr_accessor :value
    attr_accessor :children
    def initialize(name, parent=false)
        @name = name
        @parent = parent
        @children = []
        @files = []
    end

    def addNewChild(name)
        @children.push(Folder.new(name, self))
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
        temp = Folder.new(name)
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
        return  @files.map{|file| file.score}.sum + @children.map{|child| child.score}.sum
    end
end

class FFile
    attr_accessor :name
    attr_accessor :value
    attr_accessor :parent
    def initialize(name, value, parent)
        @name = name
        @parent = parent
        @value = value.to_i
    end

    def score
        return @value
    end

end

root = Folder.new('/')
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
        p current_dir
        puts "Current at #{current_dir.str}"
    else # ls results
        case line
        in ["dir", dir_name] 
            puts "new dir: '#{dir_name}'"
            current_dir.children.push(Folder.new(dir_name, current_dir))
        in [String => size, String => file_name]
            puts "New file #{file_name} (#{size})"
            current_dir.files.push(FFile.new(file_name, size, current_dir))
        end
    end

    puts
}
puts "Total space used: #{root.score}"

def space_needed(n)
    p n
    return 30000000 - (70000000 - n.score) 
end

puts "Space needed: #{space_needed(root)}"
folders = [root]
queue = [root]
total = 0
while queue.length != 0 do
    current = queue.shift
    queue.push(*current.children)
    folders.push(*current.children)
end
while true do
    folders = folders.sort_by(&:score) 
    current = folders[0]
    puts "Current folder: #{current.str} (#{current.score})"
    if space_needed(root) < current.score
        puts current.score
        break
    end
    folders.shift
end