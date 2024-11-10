function check_collisions()
	colliding = false

	-- boundary trees
	if (p_x+2)<(5*16)-tree_offset or (p_x+14)>(-4*16)+tree_offset then		
		collide()
	end

	-- obstacles
	for i=1, #objects_table do
		-- don't check for collisions for objects not on the screen
		if should_check_object(objects_table[i]) then
			if objects_table[i].object == "obstacle" then
				--if abs(p_y-objects_table[i].y) < 100 then
					if check_bounding_boxes(get_player_bounding_box(), objects_table[i]) then
						collide()
					end
				--end
			end

			-- score objects
			if objects_table[i].object == "score" then
				if not objects_table[i].taken then
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
			
			-- flags
			if objects_table[i].object == "flag" then
				--if abs(p_y-objects_table[i].y) < 100 then
				if not objects_table[i].taken then
					if check_bounding_boxes(get_player_bounding_box(), objects_table[i]) then
						score += objects_table[i].value
						sfx(1)
						objects_table[i].taken = true
					end
				end
				--end
			end
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
		sfx(3)
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

function check_bounding_boxes(obj1, obj2)
    return obj1.x < obj2.x + obj2.width and
           obj1.x + obj1.width > obj2.x and
           obj1.y < obj2.y + obj2.height and
           obj1.y + obj1.height > obj2.y
end