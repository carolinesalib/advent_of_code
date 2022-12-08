# input = <<~INPUT
#       [D]    
#   [N] [C]    
#   [Z] [M] [P]
#    1   2   3

#   move 1 from 2 to 1
#   move 3 from 1 to 3
#   move 2 from 2 to 1
#   move 1 from 1 to 2
# INPUT

file = File.open("day5_input.txt")
input = file.read

stacks_value = input.split("\n\n")[0].split("\n")
stack_numbers_line = stacks_value.last

stacks_value.pop

instructions_value = input.split("\n\n")[1].split("\n")

instructions = instructions_value.map { |insruction| insruction.scan(/\d+/).map(&:to_i) }

# p instructions

stack_hash = {}

stack_numbers_line.chars.each_with_index do |item, index|
  unless item.strip.empty?
    # p "#{item} - #{index}"
    stack_hash[item.to_i] = []

    stacks_value.reverse_each do |row|
      # p row[index]
      stack_hash[item.to_i] << row[index] unless row[index].strip.empty?
    end
  end
end

# p stack_hash

instructions.each do |move, from, to|
  # p "move #{move} from #{from} to #{to}"

  moving_elements = stack_hash[from].pop(move)
  stack_hash[to].push(*moving_elements)

  # p "moving_elements #{moving_elements}"
  # p stack_hash
end

p "Result: #{stack_hash.map { |_, value| value.last }.join}"
