function level_1_init()
	amount_of_scoring_areas = 100
	amount_of_obstacles = 200
	amount_of_ice = 30
	amount_of_small_flag_areas = 0
	amount_of_big_flag_areas = 0
	--amount_of_ice = 200
	--amount_of_obstacles = 1500
	generate_objects()
end

function level_1_update()
	update_time()
	
	if not debug_movement then
		if not freeze_player then
			move_skier()
		end
	else
		debug_move_skier()
	end

	check_collisions()
	check_finished_level()
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

	draw_hud(true)
	draw_messages()
	
	-- debug
	debug_print()
end