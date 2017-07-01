class String
  def score
    self.each_char.inject(0){|a, c| a + c.ord - 'A'.ord + 1}
  end
end

names = eval("[#{File.read(ARGV.pop)}]").sort
puts names.map.with_index{|o, i| o.score * (i+1)}.inject(&:+)
