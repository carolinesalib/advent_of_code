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
    [Scissors]
  end

  def score
    1
  end
end

class Paper
  def wins
    [Rock]
  end

  def score
    2
  end
end

class Scissors
  def wins
    [Paper]
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
  opponent_choice = opponent_choice_type.new

  my_choice = if my_choice_value == "Y"
    opponent_choice
  elsif my_choice_value == "Z"
    ([Rock, Paper, Scissors] - [opponent_choice_type] - opponent_choice.wins).first.new
  else
    opponent_choice.wins.first.new
  end

  my_choice_type = my_choice.class
  # my_choice = my_choice_type.new

  # p "#{opponent_choice_type} #{my_choice_type}"

  score = if opponent_choice_type == my_choice_type
    3
  elsif my_choice.wins.include?(opponent_choice.class)
    6
  else
    0
  end

  # p "my choice wins #{my_choice.wins} opponent choice #{opponent_choice.class}"
  # p "my_choice.score #{my_choice.score} score #{score}"

  my_score = my_choice.score + score

  # p "my_score #{my_score}"

  total_score += my_score
end

p "Total score: #{total_score}"
