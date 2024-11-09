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
			flag_knocked_offset = objects_table[i].taken and 16 or 0
			sspr(32+16*objects_table[i].blue,32+flag_knocked_offset,16,16,objects_table[i].x,objects_table[i].y,objects_table[i].width,objects_table[i].height)
			if objects_table[i].taken then
				print(objects_table[i].value,objects_table[i].x+10,objects_table[i].y-30,8)
			end
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