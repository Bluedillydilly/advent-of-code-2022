monkey_business = 0
$monkeys = []
check_points = [1, 20, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]
$lcm = 1

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
            worry = operation.(i) % $lcm # get worry after inspection

            $monkeys[test_op.(worry)].items.push(worry)
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

file = File.open("./day11/day11-input.txt").each
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
    $lcm *= test_divisor
    true_monkey, false_monkey = [file.next.strip.split()[5].to_i, file.next.strip.split()[5].to_i]
    test_op = test_operation.(test_divisor, true_monkey, false_monkey)
    $monkeys.push(Monkey.new(items, operation, test_op))
}

10000.times do |i|
    $monkeys.each do |monkey|
        monkey.turn()
    end
end

puts $monkeys.max_by(2) {|m| m.inspections}.reduce(1) {|product, m| product * m.inspections}