# frozen_string_literal: true

# input = [
#   ["A", "Y"],
#   ["B", "X"],
#   ["C", "Z"],
# ]

file = File.open("day2_input.txt")
file_data = file.read
input = file_data.split("\n").map { |item| item.split(" ") }

class Rock
  def wins
    Scissors
  end

  def score
    1
  end
end

class Paper
  def wins
    Rock
  end

  def score
    2
  end
end

class Scissors
  def wins
    Paper
  end

  def score
    3
  end
end

class A < Rock
end

class X < Rock
end

class B < Paper
end

class Y < Paper
end

class C < Scissors
end

class Z < Scissors
end

total_score = 0

input.each do |opponent_choice_value, my_choice_value|
  # p "#{opponent_choice_value} #{my_choice_value}"

  opponent_choice_type = Object.const_get(opponent_choice_value).superclass
  my_choice_type = Object.const_get(my_choice_value).superclass

  my_choice = my_choice_type.new

  # p "#{opponent_choice_type} #{my_choice_type}"

  score = if opponent_choice_type == my_choice_type
    3
  elsif my_choice.wins == opponent_choice_type
    6
  else
    0
  end

  my_score = my_choice.score + score
  total_score += my_score
end

p "Total score: #{total_score}"
