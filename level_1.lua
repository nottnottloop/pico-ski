function level_1_init()
	if not level_1_inited then
		amount_of_scoring_areas = 100
		amount_of_obstacles = 200
		--amount_of_obstacles = 1500
		generate_objects()
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
	--pal(0+12,128+12,1)
	cls(12)

	update_camera()
	
	-- obstacles
	draw_boundary_trees()
	draw_objects()

	
	-- skier
	local skier_sprite = 39
	if abs(turning_progress) >= turning_limit then
		skier_sprite += 4
	elseif abs(turning_progress) >= turning_limit / 2 then
		skier_sprite += 2
	end
	local flip_skier = false
	if (turning_progress < 0) flip_skier = true

	spr(skier_sprite,p_x,p_y,2,2,flip_skier)

	draw_time_display()
	
	-- debug
	debug_print()
end