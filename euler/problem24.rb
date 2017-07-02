#2 7 8 3 6 1 4 5 9 0

#2 arrangements of 9! that begin with 0,1,        total 725760 remaining 274240
#6 arrangements of 8! that begin with 0,1,3,4,5,6 total 967680 remaining  32320
#6 arrangements of 7! that begin with 0,1,3,4,5,6 total 997920 remaining   2080
#2 arrangements of 6! that begin with 0,1         total 999360 remaining    640
#5 arrangements of 5! that begin with 0,1,3,4,5   total 999960 remaining     40
#1 arrangement of 4! that begins with 0           total 999984 remaining     16
#2 arrangements of 3! that begin with 0,3         total 999996 remaining      4
#2 arrangements of 2! that begin with 0,3         total 1000000 remaining     0

#Last = 2783614590

digits = (0..9).to_a

target = (ARGV.shift || "1000000").to_i

class Fixnum
  @@factorials = {}

  def _!
    return 1 if self <= 1
    @@factorials[self] ||= self * (self-1)._!
  end
end

l = digits.length

while l._! > target
  l -= 1
end

arrangement = []
num = 0

while target > 0
  num = target / l._!
  delta = (num * l._!)
  target -= delta
  arrangement.push(digits.delete(digits[num]))
  puts "%d %2d %7d %7d %-10s %-10s %10s\n" % [l, num, target, digits.join, arrangement.join, arrangement.join + digits.reverse.join]
  l -= 1
end

puts "Arragements so far " + arrangement.join
puts "Digits left " + digits.join
