function update_time_display()
	minutes_display = flr((time_limit-elapsed_time)/60)
	seconds_display = flr((time_limit-elapsed_time)%60)
	milliseconds_display = flr((100-(elapsed_time-flr(elapsed_time))*100))
	if flr(seconds_display / 10) == 0 then
		seconds_display = "0"..seconds_display
	end
	if flr(milliseconds_display / 10) == 0 then
		milliseconds_display = "0"..milliseconds_display
	end
end

function draw_time_display()
	rectfill(c_x,c_y,c_x+128,c_y+1+6+4,0)
	print("score",c_x+6,c_y+0,7)
	local length_of_score = #tostr(score)
	print(score,c_x+8+5*4-length_of_score*4,c_y+6,7)
	print("time",c_x+64-(4*4)/2,c_y+0,8)
	print(minutes_display..":"..seconds_display..":"..milliseconds_display,c_x+64-(7*4)/2,c_y+6,7)
end

function check_collisions()
	colliding = false

	-- boundary trees
	if (p_x+2)<(5*16)-tree_offset or (p_x+14)>(-4*16)+tree_offset then		
		collide()
	end

	-- obstacles
	for i=1, #objects_table do
		if objects_table[i].object == "obstacle" then
			--if abs(p_y-objects_table[i].y) < 100 then
				if check_bounding_boxes(get_player_bounding_box(), objects_table[i]) then
					collide()
				end
			--end
		end

		-- score objects
		if objects_table[i].object == "score" then
			if (not objects_table[i].taken) and (abs(p_y-objects_table[i].y) < 100) then
				if check_bounding_boxes(get_player_bounding_box(), objects_table[i]) then
					score += objects_table[i].value
					sfx(0)
					objects_table[i].taken = true
				end
			end
		end
	
		-- ice
		if objects_table[i].object == "ice" then
			--if abs(p_y-objects_table[i].y) < 100 then
				if check_bounding_boxes(get_player_bounding_box(), objects_table[i]) then
					acceleration += 0.35
				end
			--end
		end
		
		-- test regular bb
		if objects_table[i].object == "none" then
			--if abs(p_y-objects_table[i].y) < 100 then
				if check_bounding_boxes(get_player_bounding_box(), objects_table[i]) then
					collide()
				end
			--end
		end
	end
end

function collide()
	colliding = true
	if not debug_collision then
		p_y += 150
		local respawn_player = true
		local trees_collide = false
		repeat
			respawn_player = true
			trees_collide = false
			for i=1, #objects_table do
				if objects_table[i].object != "none" then
					if check_bounding_boxes(get_player_bounding_box(), {x=objects_table[i].x,y=objects_table[i].y,width=objects_table[i].width+20,height=objects_table[i].height+20}) then
						respawn_player = false
						if objects_table[i].object == "boundary_trees" then
							trees_collide = true
							if (objects_table[i].trees == "left") p_x += 30
							if (objects_table[i].trees == "right") p_x -= 30
						end	
					end
				end
			end
		if (not respawn_player and not trees_collide) p_y += 30
		if (p_y > 0) p_y = 0
		until respawn_player
		started_skiing = false
		turning_progress = 0
		elapsed_time += 10
		c_jerk_x = 0
		c_jerk_y = 0
		tree_checkpoint = p_y + 0.5
	else
	--sfx(0)
	end
end

function get_player_bounding_box()
	return {x=p_x+1,y=p_y,width=13,height=16}
end

function generate_objects()
	--add(objects_table,{sprite=5,x=0,y=0})
	--add(objects_table,{value=100,x=0,y=-50,taken=false})
	
	-- out of bounds
	add(objects_table,{x=-tree_offset,y=-length_of_level,width=80,height=32767,object="boundary_trees",trees="left"})
	add(objects_table,{x=tree_offset-80+16,y=-length_of_level,width=80,height=32767,object="boundary_trees",trees="right"})
	
	-- generate scoring areas
	for i=1,amount_of_scoring_areas do
		local possible_point_values = {100, 200, 500, 1000}
		local value = possible_point_values[flr(rnd(#possible_point_values)) + 1]

		local x_shift_start = -30+rnd(4)
		local x_shift_end = 30+rnd(4)
		local width = x_shift_end + 16 - x_shift_start
		local height = 100
		-- this currently checks that the score object is not
		-- overlapping with a big score bounding box
		-- might need changing in the future
		local rand_x, rand_y = check_generation_collision(width, height)
		local start_x = rand_x + x_shift_start
		local end_x = rand_x + x_shift_end
		add(objects_table,{value=value,x=rand_x,y=rand_y,taken=false,width=#tostr(value)*4,height=6,object="score"})

		local sprite_1 = 5 + flr(rnd(3))*2
		local sprite_2 = 5 + flr(rnd(3))*2
		add(objects_table,{sprite=sprite_1,x=start_x,y=rand_y-8+rnd(4),width=16,height=16,object="obstacle"})
		add(objects_table,{sprite=sprite_2,x=end_x,y=rand_y-8+rnd(4),width=16,height=16,object="obstacle"})
		-- big score bounding box
		add(objects_table,{x=start_x,y=rand_y-height/2,width=width,height=height,object="none"})
	end
	
	-- generate flag areas
	for i=1,amount_of_flag_areas do
		local possible_point_values = {100, 200, 500}
		local value = possible_point_values[flr(rnd(#possible_point_values)) + 1]
		local flags_offset = flr(rnd(2))
		local x_flag_shift = 15 * flags_offset
		local width = (x_flag_shift * 2) + 16 + 50
		local height = 200
		local rand_x, rand_y = check_generation_collision(width, height)
		for i=1,4 do
			if (i%2==0) shift_direction = -1 else shift_direction=1
			local final_x_shift = x_flag_shift * (-1*flags_offset*shift_direction)
			--add(objects_table,{value=-100,green=i%2,x=rand_x+final_x_shift,y=rand_y+(height/4)*i,taken=false,width=12,height=12,object="flag"})
			--add(objects_table,{value=value,x=rand_x,y=rand_y+(height/4)*i+(height/8),taken=false,width=#tostr(value)*4,height=6,object="score"})
		end
		-- bounding box
		add(objects_table,{x=rand_x-8-(x_flag_shift* flags_offset)-width/2,y=rand_y,width=width,height=height,object="none"})
	end

	-- generate obstacles
	for i=1,amount_of_obstacles do
		local sprite = 5 + flr(rnd(3))*2
		local width = 16
		local height = 16
		local rand_x, rand_y = check_generation_collision(width, height) 
		add(objects_table,{sprite=sprite,x=rand_x,y=rand_y,width=width,height=height,object="obstacle"})
	end
	
	-- generate ice
	for i=1,amount_of_ice do
		local sprite = 64
		local width = 32
		local height = 32
		local rand_x, rand_y = check_generation_collision(width, height) 
		add(objects_table,{sprite=sprite,x=rand_x,y=rand_y,width=width,height=height,object="ice"})
		-- big ice bounding box
		add(objects_table,{x=rand_x,y=rand_y-height,width=width,height=height+50,object="none"})
	end
end

function check_generation_collision(width, height)
	local generate = true
	repeat
		generate = true
		rand_x = flr(rnd((tree_offset*2)-160))-tree_offset+80
		rand_y = -flr(rnd(length_of_level-300))-150
		for j=1,#objects_table do
			test_object = {x=rand_x, y=rand_y,width=width,height=height}
			if check_bounding_boxes(objects_table[j], test_object) then
				--if not debug_printed then
				--	local fields = {"x", "y", "width", "height", "object"}
				--	debug_local_file_save(objects_table[j], fields, "obj1.txt")
				--	debug_local_file_save(test_object, fields, "obj2.txt")
				--	debug_printed = true
				--end
				generate = false
			end
		end
	until generate
	return rand_x, rand_y
end

function check_bounding_boxes(obj1, obj2)
    return obj1.x < obj2.x + obj2.width and
           obj1.x + obj1.width > obj2.x and
           obj1.y < obj2.y + obj2.height and
           obj1.y + obj1.height > obj2.y
end

function update_camera()
	c_x = p_x-63+8+c_jerk_x
	c_y = p_y-120+8+c_jerk_y
	camera(c_x,c_y)
end

function draw_boundary_trees()
	if (p_y < tree_checkpoint - 30) tree_checkpoint = p_y
	for i=0,8 do
		for j=0,4 do
			spr(3,(j*16)-tree_offset,tree_checkpoint-(i*16),2,2)
			spr(3,(-j*16)+tree_offset,tree_checkpoint-(i*16),2,2)
		end
	end
end

function draw_objects()
	for i=1, #objects_table do
		-- obstacles
		if objects_table[i].object == "obstacle" then
			spr(objects_table[i].sprite,objects_table[i].x,objects_table[i].y,2,2)
		end

		-- score objects
		if objects_table[i].object == "score" then
			if not objects_table[i].taken then
				print(objects_table[i].value,objects_table[i].x,objects_table[i].y,10)
			end
		end
	
		-- flags
		if objects_table[i].object == "flag" then
			sspr(32+16*objects_table[i].green,32,16,16,objects_table[i].x,objects_table[i].y,objects_table[i].width,objects_table[i].height)
		end
	
		-- ice
		if objects_table[i].object == "ice" then
			spr(64,objects_table[i].x,objects_table[i].y,4,4)
		end
		
		-- debug
		if debug_show_hitboxes then
			print(i,objects_table[i].x,objects_table[i].y-10,7)
			--if objects_table[i].object == "none" then
			local obj = objects_table[i]
			rect(obj.x,obj.y,obj.x+obj.width,obj.y+obj.height)
			local player_box = get_player_bounding_box()
			rect(player_box.x,player_box.y,player_box.x+player_box.width,player_box.y+player_box.height)
		end
	end
end

function draw_messages()
	if not started_skiing and not debug_movement then
		start_skiing_message = "press 🅾️ to ski"
		print(start_skiing_message,63+c_x-#start_skiing_message*2,100+c_y,7)
	end
end

function debug_print()
	if draw_debug_print then
		print(p_x.." "..p_y,33+c_x,50+c_y,7)
		--print(acceleration,33+c_x,63+c_y)
		--print(turning_deacceleration)
		--print(speed)
		--pset(p_x,p_y,10)
		if colliding and debug_collision then
			print("colliding!",15+c_x,93+c_y,10)
		end
		print("cpu: "..stat(1),c_x,116+c_y,10)
		print("memory: "..stat(0),c_x,122+c_y,10)
	end
end

function debug_local_file_save(obj, fields, name)
	printh(nil, name, true)
	for i=1,#fields do
		printh(obj[fields[i]], name, false)
	end
end