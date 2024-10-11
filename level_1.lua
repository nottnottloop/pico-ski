function level_1_update()
	update_time_display()
	elapsed_time+=(1/60)
	--if elapsed_time > time_limit then
	--	game_state = "game_over"
	--end
end

function level_1_draw()
	-- darker bg
	pal(0+12,128+12,1)
	cls(12)

	rectfill(0,0,128,1+6+4,0)
	print("score",6,0,7)
	print(score,2+5*4,6,7)
	--print("time",64-(4*4)/2,0,8)
	--print(minutes_display..":"..seconds_display..":"..milliseconds_display,64-(7*4)/2,6,7)
	
	spr(1,p_x,p_y,2,2)
end