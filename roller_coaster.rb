# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

FLAT = '_'
DESC = '\\'
ASC  = '/'
OFF_COASTER = '.'

CHANGE_IN_INERTIA = {FLAT => {1 => -1 , -1 => -1 }, 
                     DESC => {1 =>  9 , -1 => -10},
                     ASC  => {1 => -10, -1 =>  9 }}
MOVEMENT = {FLAT => [0, 1], DESC => [+1, +1], ASC => [-1, +1] }

class Fixnum
    def sign
        return 1 if self == 0
        self/abs
    end
end

@inertia = gets.to_i
@w, @h = gets.split(' ').collect {|x| x.to_i}
rows = []
@h.times do
    rows << gets.chomp.split('')
end

STDERR.puts "w, h : #{@w}, #{@h}"
STDERR.puts "Rows:\n#{rows.map(&:join).join("\n")}"
STDERR.puts "Initial inertia: #{@inertia}"

@r, @c = 0, 0
@pos = 0
@dir = 1
STDERR.puts "Start : @inertia: #{@inertia}, (@r, @c): (#{@r}, #{@c})" 
STDERR.puts "Start : @pos: #{@pos}, @dir: #{@dir}"

while true
    current = rows[@r][@c]
    if current == OFF_COASTER
        current = (rows[@r+1][@c] == OFF_COASTER) ? rows[@r-1][@c] : rows[@r+1][@c]
    end
    STDERR.puts "current: #{current}"
    break if (current == FLAT && @inertia == 0) || @pos == (@w - 1)
    @inertia += CHANGE_IN_INERTIA[current][@dir]
    movement_delta = MOVEMENT[current]
    @dir = @dir * @inertia.sign
    @inertia = @inertia.abs
    @r += @dir * movement_delta.first
    @c += @dir * movement_delta.last
    if @r == @h
        @r -= 1
    end
    @pos += @dir
    STDERR.puts "@inertia: #{@inertia}, (@r, @c): (#{@r}, #{@c})" 
    STDERR.puts "@pos: #{@pos}, @dir: #{@dir}"
end

puts @pos
