words = File.read(ARGV[0])

w1 = ARGV[1]
w2 = ARGV[2]
count = 0
last_w1_loc = last_w2_loc = min_dist = 1.0/0.0

for word in words.split
	if [nil, ' '].include?(word)
		puts "Skipping blank word"
		next
	end
	count += 1
	last_w1_loc = count if word == w1
	last_w2_loc = count if word == w2
	abs_diff = (last_w1_loc - last_w2_loc).abs - 1
	puts "min_dist: #{min_dist}\tlast_w1_loc: #{last_w1_loc}\tlast_w2_loc: #{last_w2_loc}"	if abs_diff < 0
	if abs_diff < min_dist
		min_dist = abs_diff 
		puts "Min distance changed to #{min_dist} when scanning #{word} at position #{count}"
	end
end

puts "Minimum distance is #{min_dist}"
