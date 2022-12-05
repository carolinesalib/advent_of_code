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

def item_alphabetic_index(item)
  (("a".."z").to_a + ("A".."Z").to_a).find_index(item) + 1
end

result_part1 = 0
result_part2 = 0

input.each do |rucksack|
  compartment1 = rucksack.slice(0, rucksack.size / 2)
  compartment2 = rucksack.slice(rucksack.size / 2, rucksack.size)
  # p "#{compartment1} - #{compartment2}"
  shared_item = (compartment1.chars & compartment2.chars).first
  # p shared_item
  item_alphabetic_index = (("a".."z").to_a + ("A".."Z").to_a).find_index(shared_item) + 1
  # p item_alphabetic_index
  result_part1 += item_alphabetic_index
end

p "Result part 1: #{result_part1}"

input.each_slice(3) do |rucksack1, rucksack2, rucksack3|
  # p rucksack1, rucksack2, rucksack3
  shared_item = (rucksack1.chars & rucksack2.chars & rucksack3.chars).first
  # p "#{shared_item}"
  result_part2 += item_alphabetic_index(shared_item)
end

p "Result part 2: #{result_part2}"
