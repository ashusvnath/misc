STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

@surface_n = gets.to_i # the number of points used to draw the surface of Mars.
flat_start = flat_end = flat_y = nil
prev_x = prev_y = nil
@surface_n.times do
    # land_x: X coordinate of a surface point. (0 to 6999)
    # land_y: Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
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
flat_reached = false
flat_mid = (flat_end + flat_start) / 2
needs_stabilization = true
loop do
    # h_speed: the horizontal speed (in m/s), can be negative.
    # v_speed: the vertical speed (in m/s), can be negative.
    # fuel: the quantity of remaining fuel in liters.
    # rotate: the rotation angle in degrees (-90 to 90).
    # power: the thrust power (0 to 4).
    x, y, h_speed, v_speed, fuel, rotate, power = gets.split(" ").map(&:to_i)
    if (rotate.abs > 45 ) && needs_stabilization
        STDERR.puts "Waiting to stabilize"
        puts "0 0"
        next
    end
    needs_stabilization = false

    angle_needed = 0
    thrust = 0
    theta = rotate * Math::PI / 180
    t_v = (power * Math.cos(theta) - 3.711).abs
    t_h = power * Math.sin(theta)
    flat_reached = (x >= flat_start && x <= flat_end)
    vert_distance_to_ground = (y - flat_y)
    horz_distance_to_ground = flat_reached ? 0 : (x < flat_start ? flat_mid - x : x - flat_mid)

    v_y = v_speed.abs
    time_for_y_dist =  (-v_y + Math.sqrt(v_y ** 2 + 2 * t_v * vert_distance_to_ground))/t_v
    time_for_x_dist = nil
    case
        when horz_distance_to_ground == 0
            time_for_x_dist = 0
        when x < flat_start
            time_for_x_dist = h_speed < 0 ? (1.0/0.0) : horz_distance_to_ground * 1.0 / h_speed.abs
        when x > flat_end
            time_for_x_dist = h_speed > 0 ? (1.0/0.0) : horz_distance_to_ground * 1.0 / h_speed.abs
    end

    closest_flat = x > flat_end ? flat_end : flat_start

    x_covered = h_speed * time_for_y_dist + 0.5 * t_h * (time_for_y_dist ** 2)
    final_x = x + x_covered
    h_speed_final = h_speed + t_h * time_for_y_dist
    STDERR.puts "Height of flat ground #{flat_y}"
    STDERR.puts "Flat ground between #{flat_start} #{flat_end}"
    STDERR.puts "Vertical distance to flat ground #{vert_distance_to_ground}"
    STDERR.puts "Time to hit ground = #{time_for_y_dist}"
    STDERR.puts "Horizontal distance to flat ground #{horz_distance_to_ground}"
    STDERR.puts "X position reached on ground with current_hspeed #{final_x}."
    STDERR.puts "Final h_speed #{h_speed_final}"

    if !flat_reached && time_for_x_dist < time_for_y_dist && h_speed.abs > 15
        STDERR.puts "Going up!!!!"
        dir = -1 * (h_speed/h_speed.abs)
        angle_needed = -1 * 80
        puts "#{angle_needed} 4"
        next
    end

    if y < flat_y
        STDERR.puts "Yikes. Below ground. Going up!!!!"
        puts "0 4"
        next
    elsif (y > flat_y && v_speed > 0)
        STDERR.puts "Will never reach ground"
        puts "0 3"
        next
    end

=begin
    if final_x < flat_start && h_speed.abs != 0
            STDERR.puts "Wont stop before reaching flat!!"
            thrust = rotate == 0 ? 4 : 0
            puts "-90 #{thrust}"
            next
    end
    if final_x > flat_end && h_speed != 0
            STDERR.puts "Wont reach flat in time!!"
            thrust = rotate == 0 ? 4 : 0
            puts "90 #{thrust}"
            next
    end
=end


    if !flat_reached && v_speed > -35 && h_speed.abs < 20
        go_right = x < flat_mid
        STDERR.puts "Going #{go_right ? 'right' : 'left'}"
        angle_needed = 70 * (go_right ? -1 : 1)
        thrust = h_speed > 10 ? 2 : 3
    elsif (flat_reached && v_speed > -35 && h_speed.abs > 20) || (!flat_reached && time_for_x_dist < time_for_y_dist)
        STDERR.puts "Re-adjusting h_speed"
        thrust = 4
        go_right = x < flat_mid
        angle_needed = 90 * (go_right ? 1 : -1)
    elsif flat_reached
        STDERR.puts "Going down vertically"
        angle_needed = 0
        thrust = v_speed < -30 ? 4 : 3
        #thrust = 0 if rotate.abs > 30
    else
        STDERR.puts "Default"
        angle_needed = 0.0
        thrust = 4
    end
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."
    # rotate power. rotate is the desired rotation angle. power is the desired thrust power.
    puts "#{angle_needed.floor} #{thrust}"
end