function move_skier()
	if not debug_movement then
		speed = speed + acceleration
		p_y -= speed
		if (speed<minimum_speed) speed = minimum_speed
		if (btn(⬅️)) turn(-1)
		if (btn(➡️)) turn(1)
		local accelerating = false
		if btn(⬇️) then
			accelerating = true
			change_acceleration(-1)
		end
		if btn(⬆️) then
			accelerating = true
			change_acceleration(1)
		end
		if not accelerating then 
			if acceleration > 0 then
				acceleration -= acceleration_decay
			elseif acceleration < 0 then
				acceleration += acceleration_decay
			end
		end
	else
		if (btn(⬅️)) p_x-=speed
		if (btn(➡️)) p_x+=speed
		if (btn(⬇️)) p_y+=speed
		if (btn(⬆️)) p_y-=speed
	end
end

function turn(value)
end

function change_acceleration(value)
	if value == -1 then
		acceleration -= jerk
	end

	if value == 1 then
		acceleration += jerk
	end

	if (acceleration > acceleration_cap) acceleration = acceleration_cap
end