function _init()
	-- menu, transition, level_1, level_2, game_over
	game_state = "level_1"
	--game_state="menu"
	high_score = 0

	score = 0
	time_limit = 150
	elapsed_time = 0
	minutes_display = 0
	seconds_display = 0
	milliseconds_display = 0
	
	p_x = 150
	p_y = 0 
	c_x = 0
	c_y = 0
	
	speed = 5
	
	level_1_inited = false
	level_2_inited = false
	
	tree_checkpoint = p_y
	tree_offset = 256
end

function _update60()
	if game_state == "menu" then
		menu_update()
	elseif game_state == "transition" then
		transition_update()
	elseif game_state == "level_1" then
		level_1_update()
	elseif game_state == "level_2" then
		level_2_update()
	elseif game_state == "game_over" then
		game_over_update()
	end
end

function _draw()
	if game_state == "menu" then
		menu_draw()
	elseif game_state == "transition" then
		transition_draw()
	elseif game_state == "level_1" then
		level_1_draw()
	elseif game_state == "level_2" then
		level_2_draw()
	elseif game_state == "game_over" then
		game_over_draw()
	end
end