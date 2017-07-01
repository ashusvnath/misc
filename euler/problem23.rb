require 'mathn'

def sum_factors(n)
  factorization = Prime.prime_division(n)
  parts = factorization.map{|v| (v[0]**(v[1]+1)-1)/(v[0]-1)}
  parts.inject(&:*)
end

abundants = (2..28123).select{|n| n < (sum_factors(n) - n)}

non_abundant_sum = 28123.downto(2).reject do |n|
  # print "." if n % 50 == 0
  r = abundants.select{|a| a < n}
  r.find{|k| r.include?(n-k)}
end

puts non_abundant_sum.join(' ')
puts non_abundant_sum.inject(&:+) + 1
puts non_abundant_sum.size