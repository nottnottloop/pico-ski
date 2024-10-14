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
	
	p_x = 0
	p_y = 0 
	c_x = 0
	c_y = 0
	camera_jerk_cap = 24
	camera_jerk_increment = 0.5
	c_jerk_x = 0
	c_jerk_y = 0
	
	speed = 1.5
	normal_speed = 1.5
	friction = 0.01
	minimum_speed = 1.2
	speed_cap = 2.75
	acceleration = 0
	acceleration_cap = 0.02
	acceleration_decay = 0.2
	jerk = 0.0005

	level_1_inited = false
	level_2_inited = false
	
	tree_checkpoint = p_y
	tree_offset = 256
	
	length_of_level = 20000
	
	obstacles_table = {}
	score_objects_table = {}
	amount_of_obstacles = 0
	amount_of_scoring_areas = 0
	
	colliding = false

	debug_movement = false
	draw_debug_print = true
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