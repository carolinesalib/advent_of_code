file = File.open("day6_input.txt")
input = file.read
MARKER = 14

four_different_chars = []

input.chars.each_with_index do |char, index|
  four_different_chars << char

  if four_different_chars.size == MARKER
    if four_different_chars.uniq.size == MARKER
      p "Result: #{index + 1}"
      break
    else
      four_different_chars.shift
    end
  end
end
