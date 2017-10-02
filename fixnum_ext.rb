require 'mathn'

class Fixnum
  def fact
    return 1 if self >= 0 and self < 2
    self * (self - 1).fact
  end

  def combine(k)
    return self.fact /  (k.fact * (self-k).fact)
  end
end

class Range
  def sum
    self.inject(0){|a,v| a + (yield v) }
  end
end


class Array
  def lcm
    all_prime_factors = {}
    self.each do |n|
      raise "#{n.inspect} Not an integer. Cant find LCM for #{self}" unless (Fixnum === n)
      Prime.prime_division(n).each do |(p,r)|
        all_prime_factors[p] ||= r
        all_prime_factors[p] = all_prime_factors[p] < r ? r : all_prime_factors[p]
      end
    end
    all_prime_factors.inject(1){|a, (p,r)| a * (p ** r) }
  end
end

def result(f, l)
  (f..l).sum{|n| l.combine(n) } / (1.0 * 2**l)
end