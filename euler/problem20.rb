def fact(n)
  return n if(n<3)
  return n * fact(n-1)
end

puts fact(100).to_s.each_char.map(&:to_i).inject(&:+)