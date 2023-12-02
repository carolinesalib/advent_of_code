# frozen_string_literal: true

file = File.open("day1_input.txt")
file_data = file.read
input_lines = file_data.split("\n")

def convert_text_to_numbers(text)
  text_numbers = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
  }

  numbers = []

  (0...text.split("").size).each do |index|
    if text[index].gsub(/[0-9]/, "").empty?
      numbers << text[index].to_i
      next
    end

    text_numbers.each do |text_number, number|
      if text[index, text_number.size] == text_number
        numbers << number
        break
      end
    end
  end

  numbers
end

result = input_lines.sum do |input|
  numbers = convert_text_to_numbers(input)
  "#{numbers.first}#{numbers.last}".to_i
end

puts result
