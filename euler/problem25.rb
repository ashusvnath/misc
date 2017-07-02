a = 1
b = 1
iter = 2
while b.to_s.length < 1000
  a, b = b, a+b
  iter += 1
end
puts "%d\n%d %d\n%d %d\n" % [iter, a, a.to_s.length, b, b.to_s.length]