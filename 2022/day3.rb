# input = [
#   "vJrwpWtwJgWrhcsFMMfFFhFp",
#   "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
#   "PmmdzqPrVvPwwTWBwg",
#   "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
#   "ttgJtRGJQctTZtZT",
#   "CrZsJsPPZsGzwwsLwLmpwMDw"
# ]

file = File.open("day3_input.txt")
file_data = file.read
input = file_data.split("\n")

result = 0

input.each do |rucksack|
  compartment_1 = rucksack.slice(0, rucksack.size / 2)
  compartment_2 = rucksack.slice(rucksack.size / 2, rucksack.size)

  # p "#{compartment_1} - #{compartment_2}"

  shared_item = (compartment_1.chars & compartment_2.chars).first

  # p shared_item

  item_alphabetic_index = (("a".."z").to_a + ("A".."Z").to_a).find_index(shared_item) + 1

  # p item_alphabetic_index

  result += item_alphabetic_index
end

p "Result: #{result}"
