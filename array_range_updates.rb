class R
  attr_reader :a, :b, :k

  def self.[](a,b,k)
    new(a,b,k)
  end

  def initialize(a, b, k)
    raise "Error #{b} < #{a}. Can't initialize range" if b < a
    @a = a
    @b = b
    @k = k
  end

  def ===(v) @a <= v.a && @b >= v.b; end

  def ==(o) eql?(o); end

  def eql?(o)
    return false if !(R === o)
    @a == o.a && @b == o.b
  end

  def hash
    [@a, @b].hash
  end

  def to_s
    "(#{@a}..#{@b})->#{@k}"
  end

  def inspect
    to_s
  end

  def combine(o)
    both = @k + o.k
    acted = true
    result = []
    if(self == o)
      result << R[@a, @b, both]
    elsif(self === o)
      result << R[@a, o.a - 1, @k] if(@a < o.a)
      result << R[o.a, o.b, both]
      result << R[o.b + 1, @b, @k] if(@b > o.b)
    elsif(@b == o.a)
      result << R[@a, @b-1, @k] if (@b-1 >= @a)
      result << R[@b, @b, both]
      result << R[@b+1, o.b, o.k] if (@b <= o.b)
    elsif(@a == o.b)
      result << R[o.a, @a-1, o.k] if (o.a <= @a - 1)
      result << R[@a, @a, both]
      result << R[@a+1,@b, @k] if (@a+1 <= @b)
    elsif(@a == @b && o.a == o.b)
      result << R[@a, @a, both]
    elsif(@a < o.a && o.a < @b && @b < o.b)
      result << R[@a, o.a - 1, @k]
      result << R[o.a, @b, both]
      result << R[@b + 1, o.b, o.k]
    elsif(o.a < @a && @a < o.b && o.b < @b)
      result << R[o.a, @a - 1, o.k]
      result << R[@a, o.b, both]
      result << R[o.b + 1, @b, @k]
    else
      result << R[@a, @b, @k]
    end
    result
  end
end

n, m = gets.strip.split(' ').map(&:to_i)
ranges = [R[1,n,0]]
m.times do
  a, b, k = gets.strip.split(' ').map(&:to_i)
  r = R[a,b,k]
  ranges = ranges.map!{|e| e.combine(r)}.flatten
  #STDERR.puts "Merging #{r} resulted in #{ranges.inspect}"
end

#STDERR.puts ranges.inspect
puts ranges.map(&:k).max
