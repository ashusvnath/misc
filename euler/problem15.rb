class Fixnum
  @@factorials = {}

  def _!
    return 1 if self == 0
    @@factorials[self] ||= self * (self-1)._!
  end
end

puts 40._!/(20._!**2)