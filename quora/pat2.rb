row_start = 15
diff_start = 5
while row_start >= 11
	print row_start, ' '
	diff = diff_iter = diff_start
	
	while diff_iter > (15 - row_start) + 1
		print row_start - diff, ' '
		diff_iter -= 1
		diff += diff_iter
	end
	print "\n"
	row_start -= 1	
end
