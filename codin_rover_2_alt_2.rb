STDOUT.sync = true # DO NOT REMOVE
@surface_n = gets.to_i # the number of points used to draw the surface of Mars.
flat_start = flat_end = flat_y = nil
prev_x = prev_y = nil
@surface_n.times do
    land_x, land_y = gets.split(" ").map(&:to_i)
    if land_y == prev_y
        flat_start = prev_x
        flat_end = land_x
        flat_y = land_y
    else
        prev_x = land_x
        prev_y = land_y
    end
end

# game loop
loop do
    x, y, h_speed, v_speed, fuel, rotate, power = gets.split(" ").map(&:to_i)
    overshoot = (x - flat_end).abs
    angle_needed = 0
    thrust = 0
    a = power
    theta = rotate * Math::PI/180
    v_a = (a * Math.cos(theta.abs) - 3.711).abs
    h_a = a * Math.sin(theta.abs)

    if x > flat_start && x < flat_end
        STDERR.puts "Flat reached!!"
        if h_speed.abs < 20
            angle_needed = 0
            thrust = v_speed < -35 ? 4 : 3
        else
                
            x_dist = (flat_end - x)
            h_a_needed = - (h_speed.abs)**2 / 2 * x_dist
            angle_needed = Math.atan(v_a/h_a_needed)
            thrust = 4
        end
    else
        x_dist = (x - flat_start).abs
        

        v_abs = v_speed.abs
        
        time_remaining = (-v_abs + Math.sqrt(v_abs ** 2 + 2 * v_a * y))/v_a
        STDERR.puts "Time remaining #{time_remaining}"
        h_speed_needed = 3*x_dist / time_remaining
        h_a_needed = 3*(h_speed - h_speed_needed)/time_remaining
        angle_needed = Math.atan(v_a/h_a_needed) * 180 / Math::PI
        thrust = 3
    end
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."
    

    # rotate power. rotate is the desired rotation angle. power is the desired thrust power.
    puts "#{angle_needed.floor} #{thrust}"
end