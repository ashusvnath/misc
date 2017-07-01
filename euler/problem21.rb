require 'mathn'

ubound = (ARGV.pop || "10000").to_i
found = []

def sum_factors(n)
  factorization = Prime.prime_division(n)
  parts = factorization.map{|v| (v[0]**(v[1]+1)-1)/(v[0]-1)}
  parts.inject(&:*)
end

(ubound).downto(2) do |n|
  next if found.include?(n)
  m = sum_factors(n) - n
  found.push(n, m) if m > 1 && m != n && n == (sum_factors(m) - m)
end
puts found.join(' ')
puts found.inject(&:+)

