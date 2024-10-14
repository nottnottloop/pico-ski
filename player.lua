function move_skier()
	if not debug_movement then
		if (btn(⬅️)) p_x-=speed
		if (btn(➡️)) p_x+=speed

		speed = min(speed + acceleration, speed_cap)
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
			-- apply friction
			if (abs(speed - normal_speed) < 0.1) then
				speed = normal_speed
			elseif speed > normal_speed then
				speed -= friction
			elseif speed < normal_speed then
				speed += friction
			end
			
			-- decay acceleration
			if (abs(acceleration) < 0.1) then
				acceleration = 0
			elseif acceleration > 0 then
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
		-- make deaccelerating slightly easier
		acceleration -= jerk * 1.5
		if (acceleration < -acceleration_cap) acceleration = -acceleration_cap
	end

	if value == 1 then
		local jerk_multiplier = 1
		if (normal_speed - speed < 0.2) jerk_multiplier = 2
		acceleration += jerk
		if (acceleration > acceleration_cap) acceleration = acceleration_cap
	end

end