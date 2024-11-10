function check_finished_level()
	if length_of_level + p_y < 65 then
		freeze_player = true
		clock_active = false
		started_skiing = false
		ended_level_timer+=(1/60)
		if ended_level_timer > next_level_start_delay then
			reset_level_finished()
			if game_state == "level_1" then 
				level_2_init()
				game_state = "level_2"
			elseif game_state == "level_2" then
				game_state = "game_over"
			end
			_update60()
		end
	end
end

function reset_level_finished()
	freeze_player = false
	clock_active = true
	ended_level_timer = 0
	score_checkpoint = 0
	p_x = player_x_start
	p_y = player_y_start
end