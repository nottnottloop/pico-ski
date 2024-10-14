function level_1_init()
	if not level_1_inited then
		amount_of_obstacles = 200
		generate_obstacles()
		level_1_inited = true
	end
end

function level_1_update()
	if (not level_1_inited) level_1_init()
	update_time_display()
	elapsed_time+=(1/60)
	
	move_skier()
	check_collisions()
	--if elapsed_time > time_limit then
	--	game_state = "game_over"
	--end
end

function level_1_draw()
	-- darker bg from alternate palette
	pal(0+12,128+12,1)
	cls(12)

	update_camera()
	
	-- skier
	spr(1,p_x,p_y,2,2)
	
	-- obstacles
	draw_boundary_trees()
	for i=1, #obstacles_table do
		spr(obstacles_table[i].sprite,obstacles_table[i].x,obstacles_table[i].y,2,2)
	end

	draw_time_display()
	
	-- debug
	print(p_x.." "..p_y,33+c_x,63+c_y)
	pset(p_x,p_y,10)
	if colliding then
		print("colliding!",15+c_x,93+c_y)
	end
end