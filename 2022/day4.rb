# input = "2-4,6-8
# 2-3,4-5
# 5-7,7-9
# 2-8,3-7
# 6-6,4-6
# 2-6,4-8"

# input = input.split("\n").map { |item| item.split(",") }

file = File.open("day4_input.txt")
file_data = file.read
input = file_data.split("\n").map { |item| item.split(",") }

shift_overlap = 0

input.each do |section1_value, section2_value|
  section1 = section1_value.split("-")
  section2 = section2_value.split("-")
  section1_array = (section1[0]..section1[1]).to_a
  section2_array = (section2[0]..section2[1]).to_a

  # p "Section 1: #{section1} - Section 2: #{section2}"
  # p "Section 1: #{section1_array} - Section 2: #{section2_array}"

  if (section1_array & section2_array).any? || (section2_array & section1_array).any?
    shift_overlap += 1
  end
end

p "Shift overlap: #{shift_overlap}"
