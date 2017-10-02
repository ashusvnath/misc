def pyramid(n)
  next_row = lambda{|row| row[0..-2].map.with_index{|_,i| row[i] + row[i+1]} }
  current = (1..n).to_a.permutation.map(&next_row)
  while current.first.size > 1
    current = current.map(&next_row)
  end
  current.sort!
  current.first.first + current.last.first
end