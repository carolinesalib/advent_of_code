# frozen_string_literal: true

file = File.open("day2_input.txt")
file_data = file.read
input_lines = file_data.split("\n")

AVAILABLE_RED_CUBES = 12
AVAILABLE_GREEN_CUBES = 13
AVAILABLE_BLUE_CUBES = 14

def enough_cubes?(game_cubes)
  game_cubes.split(", ").each do |cubes|
    number_of_cubes = cubes.strip.split(" ").first.to_i
    cube_colour = cubes.strip.split(" ").last

    if cube_colour == "red" && number_of_cubes > AVAILABLE_RED_CUBES ||
        cube_colour == "green" && number_of_cubes > AVAILABLE_GREEN_CUBES ||
        cube_colour == "blue" && number_of_cubes > AVAILABLE_BLUE_CUBES
      return false
    end
  end

  true
end

result = 0

input_lines.each do |game|
  game_number = game.split(": ").first.gsub(/\D/, "").to_i
  game_line = game.split(": ").last

  enough_cubes_game = true

  game_line.split(";").each do |game_cubes|
    unless enough_cubes?(game_cubes)
      enough_cubes_game = false
      break
    end
  end

  enough_cubes_game && result += game_number
end

puts "Result: #{result}"
