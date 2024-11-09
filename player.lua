function move_skier()
	accelerating = false
	turning = false
	if p_y < score_checkpoint then
		score += 1
		score_checkpoint = p_y - 40
	end

	if btn(🅾️) then
		started_skiing = true
	end

	if started_skiing then
		if btn(⬅️) then
			turn(-1)
		elseif btn(➡️) then
			turn(1)
		else
			turning_progress = 0
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
			if abs(turning_progress) > turning_limit * 0.65 then
				normal_speed = 2.25
				friction = 0.02
			end
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
	end
end

function turn(value)
	turning = true
	if value == -1 then
		if (turning_progress > 0) turning_progress = 0
		p_x-=speed
		turning_progress -= 0.01
		c_jerk_x-=camera_jerk_increment
	end

	if value == 1 then
		if (turning_progress < 0) turning_progress = 0
		p_x+=speed
		turning_progress += 0.01
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
		-- make deaccelerating slightly harder
		acceleration -= jerk * 0.75
	end

	if value == 1 then
		acceleration += jerk
	end
	if (acceleration <= -acceleration_cap * 0.75) acceleration = -acceleration_cap * 0.75
	if (acceleration >= acceleration_cap) acceleration = acceleration_cap
end

function draw_skier()
	skier_sprite = 39
	if abs(turning_progress) >= turning_limit then
		skier_sprite += 4
	elseif abs(turning_progress) >= turning_limit / 2 then
		skier_sprite += 2
	end
	local flip_skier = false
	if (turning_progress > 0) flip_skier = true

	spr(skier_sprite,p_x,p_y,2,2,flip_skier)
end

function debug_move_skier()
	local speed = debug_speed
	if (btn(🅾️)) speed = 0.5 
	if (btn(⬅️)) p_x-=speed
	if (btn(➡️)) p_x+=speed
	if (btn(⬇️)) p_y+=speed
	if (btn(⬆️)) p_y-=speed
end