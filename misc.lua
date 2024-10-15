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
	--print("time",c_x+64-(4*4)/2,c_y+0,8)
	--print(minutes_display..":"..seconds_display..":"..milliseconds_display,c_x+64-(7*4)/2,c_y+6,7)
end

function check_collisions()
	colliding = false
	-- obstacles
	for i=1, #objects_table do
		if objects_table[i].object == "obstacle" then
			if abs(p_y-objects_table[i].y) < 100 then
				if (p_x+2)<objects_table[i].x+16 and ((p_x+2)+12)>objects_table[i].x and (p_y)<objects_table[i].y+16 and (p_y+16)>objects_table[i].y then
					collide()
				end
			end
		end
	end

	-- boundary trees
	if (p_x+2)<(5*16)-tree_offset or (p_x+14)>(-4*16)+tree_offset then		
		collide()
	end

	-- score objects
	for i=1, #objects_table do
		if objects_table[i].object == "score" then
			if (not objects_table[i].taken) and (abs(p_y-objects_table[i].y) < 100) then
				local length = #tostr(objects_table[i].value) * 4
				if (p_x+2)<objects_table[i].x+length and ((p_x+2)+12)>objects_table[i].x and (p_y)<objects_table[i].y+6 and (p_y+6)>objects_table[i].y then
					score += objects_table[i].value
					sfx(0)
					objects_table[i].taken = true
				end
			end
		end
	end
end

function collide()
	--sfx(0)
	colliding = true
end

function generate_objects()
	--add(objects_table,{sprite=5,x=0,y=0})
	--add(objects_table,{value=100,x=0,y=-50,taken=false})
	
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
		add(objects_table,{value=value,x=rand_x,y=rand_y,taken=false,width=16,height=6,object="score"})

		local sprite_1 = 5 + flr(rnd(3))*2
		local sprite_2 = 5 + flr(rnd(3))*2
		add(objects_table,{sprite=sprite_1,x=start_x,y=rand_y-8+rnd(4),width=16,height=16,object="obstacle"})
		add(objects_table,{sprite=sprite_2,x=end_x,y=rand_y-8+rnd(4),width=16,height=16,object="obstacle"})
		-- big score bounding box
		add(objects_table,{x=start_x,y=rand_y-height/2,width=width,height=height,object="none"})
	end
	
	-- generate obstacles
	for i=1,amount_of_obstacles do
		local sprite = 5 + flr(rnd(3))*2
		local width = 16
		local height = 16
		local rand_x, rand_y = check_generation_collision(width, height) 
		add(objects_table,{sprite=sprite,x=rand_x,y=rand_y,width=width,height=height,object="obstacle"})
	end
end

function check_generation_collision(width, height)
	repeat
		local generate = true
		rand_x = flr(rnd((-160)+tree_offset*2))-tree_offset+80
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
	if (flr(p_y) % 80 < 3) tree_checkpoint = p_y
	for i=0,20 do
		for j=0,4 do
			spr(3,(j*16)-tree_offset,tree_checkpoint+80-(i*16),2,2)
			spr(3,(-j*16)+tree_offset,tree_checkpoint+80-(i*16),2,2)
		end
	end
end

function draw_objects()
	-- obstacles
	for i=1, #objects_table do
		if objects_table[i].object == "obstacle" then
			spr(objects_table[i].sprite,objects_table[i].x,objects_table[i].y,2,2)
		end
	end

	-- score objects
	for i=1, #objects_table do
		if objects_table[i].object == "score" then
			if not objects_table[i].taken then
				print(objects_table[i].value,objects_table[i].x,objects_table[i].y,10)
			end
		end
	end
	
	-- debug
	--for i=1, #objects_table do
	--	print(i,objects_table[i].x,objects_table[i].y-10,7)
	--	--if objects_table[i].object == "none" then
	--		local obj = objects_table[i]
	--		rect(obj.x,obj.y,obj.x+obj.width,obj.y+obj.height)
	--	--end
	--end
end

function debug_print()
	if draw_debug_print then
		print(p_x.." "..p_y,33+c_x,50+c_y)
		print(acceleration,33+c_x,63+c_y)
		print(speed)
		pset(p_x,p_y,10)
		if colliding then
			print("colliding!",15+c_x,93+c_y)
		end
		print("cpu: "..stat(1),c_x,116+c_y)
		print("memory: "..stat(0),c_x,122+c_y)
	end
end

function debug_local_file_save(obj, fields, name)
	printh(nil, name, true)
	for i=1,#fields do
		printh(obj[fields[i]], name, false)
	end
end