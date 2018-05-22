n = gets.chomp.to_i
n.times do 
t = gets.chomp
s = gets.chomp
r = t
k = 0
results = []
f = 0
while k && r.length > 0
    k = r.index(s)
    next unless k
    results << (f + k + 1)
    f = f + k + 1
    r = r[k+1..-1]
    #STDERR.puts r, k, f
end
puts results.join(' ')
end
