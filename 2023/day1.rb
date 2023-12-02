# frozen_string_literal: true

file = File.open("day1_input.txt")
file_data = file.read
input_lines = file_data.split("\n")

result = input_lines.sum do |input|
  numbers = input.gsub(/[^0-9]/, "").split("")
  (numbers.first + numbers.last).to_i
end

puts result
