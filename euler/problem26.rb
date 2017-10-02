upper = (ARGV.shift || "999").to_i
3.step(upper, 2) {|n|
  next if n%5 == 0
  regex = /\d*(\d{#{n-5},#{n-1}})\1/
  x = 1.0/n
  big_x = (x * (10**(2*(n-1)))).floor
  puts regex.inspect
  puts "n:%s 1/%s = %s %s" % [n, n, x, big_x]
  puts big_x.to_s.match(regex).to_a.last
}