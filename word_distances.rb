words = File.read(ARGV[0])

word1 = ARGV[1]
word2 = ARGV[2]
count = 0

words_dict = {}

for word in words.split
	if [nil, ' '].include?(word)
		puts "Skipping blank word"
		next
	end
	count += 1
	words_dict[word] ||= []
	words_dict[word] << count
end

word1_locs = words_dict[word1].dup
word2_locs = words_dict[word2].dup
global_min_distance = 1.0/0.0

while(word1_locs.length > 0 && word2_locs.length > 0)
	start = [word1_locs.first, word2_locs.first].min
	if word1_locs.first == start 
		word1_locs.shift
		look_in = word2_locs
	else
		word2_locs.shift
		look_in = word1_locs
	end
	current_min_dist = look_in.map{|v| (v - start - 1)}.min
	global_min_distance = current_min_dist if current_min_dist < global_min_distance
end

puts "The shortest distance between '#{word1}' and '#{word2}' is #{global_min_distance}"
