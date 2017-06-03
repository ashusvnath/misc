def score(expr)
  ops = expr.scan(/[!+-\/*scf]/).count
  ones = expr.scan(/1/).count
  ops * ones
end

def c(x)
  (x*1.0).ceil
end

def f(x)
  (x*1.0).floor
end

def s(x)
  Math.sqrt(x)
end

class Fixnum
	@@facts = {0 => 1, 1 => 1, 2 => 2}
	def fact
  		return 0 if self < 0
  		@@facts[self] ||= self * (self-1).fact
	end
end

def val(expr)
  eval(expr.gsub(/!/, ".fact"))
end

@digits = ["1-1", "1", "1+1", "f(s(11))", "c(s(11))", "c(s(11)) + 1", "f(s(11))!", "f(s(11))!+1", "11-f(s(11))", "11-1-1", "11-1"]
@ones = (1..10).inject([1]){|a,v| a + [a.last*10 + 1]}
#@digits.each{|e| puts "#{val(e)} => #{e} : Score #{score(e)}"}


def decompose_1s(number)
  return "" if number <= 0
  return @digits[number] if number < 12
  num_as_string = number.to_s
  return number.to_s if !(number.to_s =~ /[^1]/)
  num_digits = number.to_s.length
  pick = @ones[num_digits - 1]
  lower_pick = @ones[[num_digits - 2, 0].max]
  closest_1s_num =  pick < number ? pick : lower_pick
  current_representation = "#{closest_1s_num}"
  quot = (number / closest_1s_num).floor
  current_representation += " * (#{@digits[quot]})" if  quot > 1
  next_decomposition = decompose_1s(number - quot * closest_1s_num)
  current_representation += " + #{next_decomposition}" if next_decomposition != ""
  return current_representation
end

number = 0
if ARGV.length == 0
  puts "Enter a number to decompose : "
  number = gets.to_i
else
  number = ARGV[0].to_i
end
decomposition = decompose_1s(number)
puts "Decomposition of #{number} is #{decomposition} , Score: #{score(decomposition)}"