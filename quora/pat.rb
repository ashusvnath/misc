x = (1..15).to_a
y = []
1.upto(5){|i| y << (x.shift(i).reverse + [nil] * (5 - i)) }
puts y.transpose.map{|k| k.reverse.join(' ')}.join("\n")
