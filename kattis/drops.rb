def doit(inp)
  _a = 0
  n,r,k,x,a,b = inp.split.map(&:to_i)
  STDERR.puts "n,r,k,x,a,b:#{[n,r,k,x,a,b]}"
  bu = [0] * n

  l = lambda {|t| (a * t + b) % n }
  v = lambda {|o| (_a * 53 + o) % 199933 }
  t = x
  begin
    r.times do
      t = l.call(t)
      bu[t] += 1
      if bu[t] > k
        if t == 0
          raise "OVERFLOW"
        else
          bu[t] -= 1
          t -= 1 while bu[t] == k
          bu[t] += 1
        end
      end
      _a = v.call(t)
      STDERR.puts "#{bu.inspect} ,t: #{t}, _a : #{_a}"
    end
    puts _a
  rescue => e
    puts e.message
  end
end

while inp = gets
  doit(inp)
end