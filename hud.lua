function update_time()
	minutes_display = flr((time_limit-elapsed_time)/60)
	seconds_display = flr((time_limit-elapsed_time)%60)
	milliseconds_display = flr((100-(elapsed_time-flr(elapsed_time))*100))
	if (milliseconds_display == 100) milliseconds_display = 0
	if flr(seconds_display / 10) == 0 then
		seconds_display = "0"..seconds_display
	end
	if flr(milliseconds_display / 10) == 0 then
		milliseconds_display = "0"..milliseconds_display
	end
	if (clock_active) elapsed_time+=(1/60)
end

function draw_hud(playing)
	rectfill(c_x,c_y,c_x+128,c_y+1+6+4,0)
	draw_score()
	if (playing) draw_time() else draw_high_score()
end

function draw_score()
	local length_of_score = #tostr(score)
	print("score",c_x+6,c_y+0,7)
	print(score,c_x+8+5*4-length_of_score*4,c_y+6,7)
end

function draw_high_score()
	print("high score",c_x+45,c_y+0,11)
	local length_of_score = #tostr(high_score)
	print(high_score,c_x+61+5*4-length_of_score*4,c_y+6,7)
end

function draw_time()
	print("time",c_x+64-(4*4)/2,c_y+0,8)
	print(minutes_display..":"..seconds_display..":"..milliseconds_display,c_x+64-(7*4)/2,c_y+6,7)
end