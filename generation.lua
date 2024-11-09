function generate_rand_x_and_y_coords()
	local rand_x = flr(rnd((tree_offset*2)-160))-tree_offset+80
	local rand_y = -flr(rnd(length_of_level-300))-150
	return rand_x, rand_y
end

function check_generation_collision(obj)
	local generate = true
	for j=1,#objects_table do
		if check_bounding_boxes(objects_table[j], obj) then
			--if not debug_printed then
			--	local fields = {"x", "y", "width", "height", "object"}
			--	debug_local_file_save(objects_table[j], fields, "obj1.txt")
			--	debug_local_file_save(test_object, fields, "obj2.txt")
			--	debug_printed = true
			--end
			generate = false
		end
	end
	return generate
end

function generate_scoring_area()
	possible_point_values = {100, 200, 500, 1000}
	value = possible_point_values[flr(rnd(#possible_point_values)) + 1]
	repeat
		x_shift_start = -30+rnd(4)
		x_shift_end = 30+rnd(4)
		width = x_shift_end + 16 - x_shift_start
		height = 100
		rand_x, rand_y = generate_rand_x_and_y_coords()
		start_x = rand_x + x_shift_start
		end_x = rand_x + x_shift_end
		bounding_box = {x=start_x,y=rand_y-height/2,width=width,height=height,object="none"}
		generate = check_generation_collision(bounding_box, generate_scoring_area)
	until generate
	
	-- big score bounding box
	add(objects_table, bounding_box)
	add(objects_table,{value=value,x=rand_x,y=rand_y,taken=false,width=#tostr(value)*4,height=6,object="score"})

	sprite_1 = 5 + flr(rnd(3))*2
	sprite_2 = 5 + flr(rnd(3))*2
	add(objects_table,{sprite=sprite_1,x=start_x,y=rand_y-8+rnd(4),width=16,height=16,object="obstacle"})
	add(objects_table,{sprite=sprite_2,x=end_x,y=rand_y-8+rnd(4),width=16,height=16,object="obstacle"})
end

function generate_flag_area()
	possible_point_values = {100, 200, 500}
	value = possible_point_values[flr(rnd(#possible_point_values)) + 1]
	repeat
		flags_offset = flr(rnd(2))
		x_flag_shift = 15 * flags_offset
		width = (x_flag_shift * 2) + 16 + 50
		height = 200
		rand_x, rand_y = generate_rand_x_and_y_coords()
		-- bounding box
		bounding_box = {x=rand_x-8-(x_flag_shift* flags_offset)-width/2,y=rand_y,width=width,height=height,object="none"}
		generate = check_generation_collision(bounding_box)
	until generate

	add(objects_table, bounding_box)
	for i=1,4 do
		if (i%2==0) shift_direction = -1 else shift_direction=1
		local final_x_shift = x_flag_shift * (-1*flags_offset*shift_direction)
		add(objects_table,{value=-100,green=i%2,x=rand_x+final_x_shift,y=rand_y+(height/4)*i,taken=false,width=12,height=12,object="flag"})
		add(objects_table,{value=value,x=rand_x,y=rand_y+(height/4)*i+(height/8),taken=false,width=#tostr(value)*4,height=6,object="score"})
	end
end

function generate_obstacle()
	sprite = 5 + flr(rnd(3))*2
	width = 16
	height = 16
	repeat
		rand_x, rand_y = generate_rand_x_and_y_coords()
		obstacle = {sprite=sprite,x=rand_x,y=rand_y,width=width,height=height,object="obstacle"}
		generate = check_generation_collision(obstacle) 
	until generate
	add(objects_table, obstacle)
end

function generate_ice()
	sprite = 64
	width = 32
	height = 32
	repeat
		rand_x, rand_y = generate_rand_x_and_y_coords()
		bounding_box = {x=rand_x,y=rand_y-height,width=width,height=height+50,object="none"}
		generate = check_generation_collision(bounding_box) 
	until generate
	add(objects_table, bounding_box)
	add(objects_table,{sprite=sprite,x=rand_x,y=rand_y,width=width,height=height,object="ice"})
end