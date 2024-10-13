function level_1_init()
	
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
	-- darker bg
	pal(0+12,128+12,1)
	cls(12)

	draw_boundary_trees()
	update_camera()
	draw_time_display()
	spr(1,p_x,p_y,2,2)
	print(p_x.." "..p_y,33+c_x,63+c_y)
	pset(p_x,p_y,10)
end