STDOUT.sync = true # DO NOT REMOVE
# Don't let the machines win. You are humanity's last hope...

@width = gets.to_i # the number of cells on the X axis
@height = gets.to_i # the number of cells on the Y axis
found = []
row_prev = []
col_prev = []
0.upto(@height-1) do |i|
    line = gets.chomp # width characters, each either 0 or .
    line.split('').each_with_index{|c, j|
        node = {src: [i,j]}
        found << node
        if row_prev[i].nil ?
            row_prev[i] = node
        else
            row_prev[i].merge!({horz: [i,j]})
            row_prev[i] = node
        end
        if cow_prev[j].nil ?
            col_prev[j] = node
        else
            col_prev[j].merge!({vert: [i,j]})
            col_prev[j] = node
        end

    }
end


found.each{|node|
    node[:horz] ||= [-1, -1]
    node[:vert] ||= [-1, -1]
    result =  "%d %d %d %d %d %d" % [node[:src][0], node[:src][1],
                                node[:horz][0], node[:horz][1],
                                node[:vert][0], node[:vert][1]]
    puts result
}