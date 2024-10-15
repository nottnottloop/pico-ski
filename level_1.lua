function level_1_init()
	if not level_1_inited then
		amount_of_scoring_areas = 100
		amount_of_obstacles = 300
		amount_of_ice = 30
		--amount_of_ice = 200
		--amount_of_obstacles = 1500
		generate_objects()
		level_1_inited = true
	end
end

function level_1_update()
	if (not level_1_inited) level_1_init()
	update_time_display()
	elapsed_time+=(1/60)
	
	if not debug_movement then
		move_skier()
	else
		debug_move_skier()
	end

	check_collisions()
	if (p_y < -length_of_level) _init()
	--if elapsed_time > time_limit then
	--	game_state = "game_over"
	--end
end

function level_1_draw()
	-- darker bg from alternate palette
	--pal(0+12,128+12,1)
	cls(12)

	update_camera()
	
	-- obstacles
	draw_boundary_trees()
	draw_objects()

	-- skier
	draw_skier()

	draw_time_display()
	
	-- debug
	debug_print()
end