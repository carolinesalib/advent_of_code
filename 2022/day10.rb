input = "addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop"

file = File.open("day10_input.txt")
input = file.read
input = input.split("\n").map { |i| i.split(" ") }
cycle_count = 0

class SignalStrengthCalculator
  attr_reader :signal_strength, :register_x, :cycle_break, :CRT_drawning

  def initialize
    @signal_strength = {
      20 => 0,
      60 => 0,
      100 => 0,
      140 => 0,
      180 => 0,
      220 => 0,
    }

    @CRT_drawning = {
      40 => "",
      80 => "",
      120 => "",
      160 => "",
      200 => "",
      240 => "",
    }

    @register_x = 1
  end

  def sprite_position
    Array.new(40, ".").fill("#", @register_x - 1, 3)
  end

  def draw_pixel(cycle)
    @CRT_drawning.each do |index, value|
      if value.size < 40
        @CRT_drawning[index] = value + sprite_position[@CRT_drawning[index].size]
        return
      end
    end
  end

  def add_register(value)
    @register_x += value.to_i
  end

  def total_signal_strength
    signal_strength.map { |_,v| v}.sum
  end

  def add_strength(cycle_count, value)
    if signal_strength[cycle_count]
      @signal_strength[cycle_count] = cycle_count * @register_x
    end
  end
end

signal_strength_calculator = SignalStrengthCalculator.new

input.each do |instruction, value|
  cycles = instruction == "addx" ? 2 : 1

  cycles.times do |i|
    cycle_count += 1
    signal_strength_calculator.draw_pixel(cycle_count)
    signal_strength_calculator.add_strength(cycle_count, value)
  end

  signal_strength_calculator.add_register(value)
end

p signal_strength_calculator.total_signal_strength
pp signal_strength_calculator.CRT_drawning.map { |_, v| v }
