monkey_business = 0
$monkeys = []

class Monkey
    attr_accessor :items
    attr_accessor :operation
    attr_accessor :test_op
    attr_accessor :inspections

    def initialize(items, operation, test_op)
        @items = items
        @operation = operation
        @test_op = test_op
        @inspections = 0
    end

    def turn()
        @inspections += @items.length
        while @items.length != 0
            i = @items.shift
            worry = operation.(i) # get worry after inspection
            worry = worry.div(3) # relief
            destination = test_op.(worry)
            $monkeys[destination].items.push(worry)
        end
    end
end

operation1 = lambda {|op|
    lambda {|newValue|
        lambda {|oldValue| [oldValue, newValue].reduce(op)}    
    }
}

operation2 = lambda {|op|
    lambda {|newValue|
        lambda {|oldValue| operation1.(op).(oldValue).(oldValue)}    
    }
}

test_operation = lambda {|divisor, tm, fm|
    lambda {|value|
        if value % divisor == 0
            return tm
        else
            return fm
        end
    }
}

file = File.open("./day11/day11-test.txt").each
file.each {|line|
    if line == "\n"
        next
    end

    line.next
    items = file.next.strip.split()[2..].map{|i| i.to_i}
    op, op_param = file.next.strip.split()[4..]
    if op_param == "old"    # old OP old
        operation = operation2
    else                    # old OP new
        operation = operation1
        op_param = op_param.to_i
    end
    if op == "+"     # ADDITION
        operation = operation.(:+)
    else                    # MULTIPLICATION
        operation = operation.(:*)
    end
    operation = operation.(op_param)    # SECOND OPERAND
    test_divisor = file.next.strip.split()[3].to_i
    true_monkey, false_monkey = [file.next.strip.split()[5].to_i, file.next.strip.split()[5].to_i]
    test_op = test_operation.(test_divisor, true_monkey, false_monkey)
    $monkeys.push(Monkey.new(items, operation, test_op))
}

def round()
    $monkeys.each do |monkey|
        monkey.turn()
    end
end

20.times do |i|
    round()
end

puts $monkeys.max_by(2) {|m| m.inspections}.reduce(1) {|product, m| product * m.inspections}