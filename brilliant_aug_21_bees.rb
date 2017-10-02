Q = 'q'
M = 'm'
generations = [[Q]]

prev = generations.first
while generations.count < 21
  current = prev.inject([]){|a, v| v == Q ? a + [Q, M] : a + [Q]}
  prev = current
  generations << current
end

puts "Ancestors in 20th generation %d" % [generations.last.count]