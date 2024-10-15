function move_skier()
	if not debug_movement then
		accelerating = false
		turning = false

		if btn(⬅️) then
			turn(-1)
		elseif btn(➡️) then
			turn(1)
		end

			if btn(⬇️) then 
				change_acceleration(-1)
			elseif btn(⬆️) then
				change_acceleration(1)
			end

		if not turning then
			normal_speed = original_normal_speed
			friction = original_friction
			if (c_jerk_x < 0) c_jerk_x += camera_jerk_increment * 0.5
			if (c_jerk_x > 0) c_jerk_x -= camera_jerk_increment * 0.5
		else
			normal_speed = 1.9
			friction = 0.02
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

		--acceleration += turning_deacceleration

		speed = min(speed + acceleration, speed_cap)
		
		--if (turning_deacceleration < 0) turning_deacceleration -= turning_deacceleration_increment

		p_y -= speed
		if (speed<minimum_speed) speed = minimum_speed

	else
		if (btn(⬅️)) p_x-=debug_speed
		if (btn(➡️)) p_x+=debug_speed
		if (btn(⬇️)) p_y+=debug_speed
		if (btn(⬆️)) p_y-=debug_speed
	end
end

function turn(value)
	turning = true
	if value == -1 then
		p_x-=speed
		c_jerk_x-=camera_jerk_increment
	end

	if value == 1 then
		p_x+=speed
		c_jerk_x+=camera_jerk_increment
	end
	
	--turning_deacceleration += turning_deacceleration_increment
	--if (turning_deacceleration < turning_deacceleration_cap) turning_deacceleration = turning_deacceleration_cap
	
	if (c_jerk_x > camera_jerk_cap) c_jerk_x = camera_jerk_cap
	if (c_jerk_x < -camera_jerk_cap) c_jerk_x = -camera_jerk_cap
end

function change_acceleration(value)
	accelerating = true
	if value == -1 then
		-- make deaccelerating slightly easier
		acceleration -= jerk * 1.75
		if (acceleration < -acceleration_cap) acceleration = -acceleration_cap
	end

	if value == 1 then
		acceleration += jerk
		if (acceleration > acceleration_cap) acceleration = acceleration_cap
	end

end