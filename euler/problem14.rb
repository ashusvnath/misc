class CollatzChainLengthCalculator
  def initialize
    @chain_lengths = {2 => 1}
  end

  def calculate(n)
    @chain_lengths[n] ||= 1 + calculate(n%2 == 0 ? n/2 : (3*n + 1))
  end

  def length_of_longest
    @chain_lengths.values.max
  end

  def start_of_longest
    @chain_lengths.keys[@chain_lengths.values.index(length_of_longest)]
  end
end

cclc = CollatzChainLengthCalculator.new
999999.downto(2) do |n|
  cclc.calculate(n)
end
puts "%d %d" % [cclc.start_of_longest, cclc.length_of_longest]