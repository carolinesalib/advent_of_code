input = "Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1"

file = File.open("day11_input.txt")
input = file.read

class ConvertStringToMonkey
  def self.run(string)
    monkey_array = string.split("\n")
    monkey = Monkey.new
    monkey.name = monkey_array[0].delete(":")
    monkey.items = monkey_array[1].delete("  Starting items: ").split(",").map(&:to_i)
    monkey.operation = monkey_array[2].gsub("Operation: new = ", "").strip.split(" ")
    monkey.dividend = monkey_array[3].chars.last(2).join.to_i
    monkey.next_monkey_true_index = monkey_array[4].gsub("If true: throw to monkey ", "").to_i
    monkey.next_monkey_false_index = monkey_array[5].gsub("If false: throw to monkey ", "").to_i

    monkey
  end
end

class Monkey
  attr_accessor :name,
    :items,
    :operation,
    :dividend,
    :next_monkey_true_index,
    :next_monkey_false_index,
    :print_result,
    :inspected_items

  def initialize
    @inspected_items = []
  end

  def round(monkey_rounds, all_dividends)
    print_result = "#{name}:\n"

    items.each do |item|
      old = item.to_i
      worry_level = eval(operation.join)
      new_worry_level = worry_level % all_dividends.reduce(:*)
      worry_test = new_worry_level % dividend == 0
      next_monkey_index = worry_test ? next_monkey_true_index : next_monkey_false_index

      print_result += "   Monkey inspects an item with a worry level of #{item}\n"
      print_result += "     Worry level is multiplied by #{eval(operation.last)} to #{worry_level}.\n"
      print_result += "     Monkey gets bored with item. Worry level is divided by 3 to #{new_worry_level}.\n"
      print_result += "     Current worry level is#{worry_test ? "" : " not"} divisible by #{dividend}.\n"
      print_result += "     Item with worry level #{new_worry_level} is thrown to monkey #{next_monkey_index}.\n"

      monkey_rounds.add_new_round(new_worry_level, next_monkey_index)
    end

    @inspected_items << items.size
    @items = []

    @print_result = print_result

    monkey_rounds
  end
end

class MonkeyRounds
  attr_reader :monkeys

  def initialize(monkeys)
    @monkeys = monkeys
  end

  def add_new_round(new_worry_level, next_monkey_index)
    monkeys[next_monkey_index].items << new_worry_level
  end
end
monkeys = []

input.split("\n\n").map do |monkey|
  monkeys << ConvertStringToMonkey.run(monkey)
end

monkey_rounds = MonkeyRounds.new(monkeys)
all_dividends = monkeys.map(&:dividend)

10000.times do |round|
  monkeys.size.times do |index|
    monkey_rounds = monkeys[index].round(monkey_rounds, all_dividends)
    # pp monkeys[index].print_result
    monkeys = monkey_rounds.monkeys
  end

  # monkeys.each do |monkey|
  #   p "Round #{round} #{monkey.name} #{monkey.items} #{monkey.inspected_items.sum}"
  # end
  p "Round #{round}"
end

p monkeys.map(&:inspected_items).map(&:sum).max(2).inject(:*)
