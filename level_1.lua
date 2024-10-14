function level_1_init()
	if not level_1_inited then
		amount_of_obstacles = 1000
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
	if (p_y > length_of_level) _init()
	--if elapsed_time > time_limit then
	--	game_state = "game_over"
	--end
end

function level_1_draw()
	-- darker bg from alternate palette
	pal(0+12,128+12,1)
	cls(12)

	update_camera()
	
	-- obstacles
	draw_boundary_trees()
	for i=1, #obstacles_table do
		spr(obstacles_table[i].sprite,obstacles_table[i].x,obstacles_table[i].y,2,2)
	end
	
	-- skier
	spr(1,p_x,p_y,2,2)

	draw_time_display()
	
	-- debug
	debug_print()
end