# frozen_string_literal: true

file = File.open("day2_input.txt")
file_data = file.read
input_lines = file_data.split("\n")

result = 0

input_lines.each do |game|
  game_line = game.split(": ").last

  max_number_of_cubes_from_each_colour = {
    "red" => 0,
    "green" => 0,
    "blue" => 0,
  }

  game_line.split(";").each do |game_cubes|
    hash_games = game_cubes.split(",").map(&:strip).map do |game_cube_line|
      [game_cube_line.split(" ").last, game_cube_line.split(" ").first.to_i]
    end

    hash_games.map do |cube_type, number_cubes|
      if number_cubes > max_number_of_cubes_from_each_colour[cube_type]
        max_number_of_cubes_from_each_colour[cube_type] = number_cubes
      end
    end
  end

  result += max_number_of_cubes_from_each_colour.values.inject(:*)
end

puts "Result: #{result}"
