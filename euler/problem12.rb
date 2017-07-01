require 'mathn'

k = (ARGV.shift || "2").to_i

num_divisors = lambda{|n| Prime.prime_division(n).inject(1){|a, v| a*(v[1]+1)}}
triangular = lambda{|n| n*(n-1)/2 }

n = k

# begin
#   t = triangular.call(n)
#   found_divisors = num_divisors.call(t)
#   puts "%d %d %d" % [n, t, found_divisors]
#   n *= k
# end while found_divisors < 500

found = []

def found.<<(n)
  puts "Adding #{n}"
  super(n)
end

13376.downto(2) do |n|
  t = triangular.call(n)
  found << t if(num_divisors.call(t) > 500)
end