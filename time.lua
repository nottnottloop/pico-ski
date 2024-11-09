function update_time_display()
	minutes_display = flr((time_limit-elapsed_time)/60)
	seconds_display = flr((time_limit-elapsed_time)%60)
	milliseconds_display = flr((100-(elapsed_time-flr(elapsed_time))*100))
	if flr(seconds_display / 10) == 0 then
		seconds_display = "0"..seconds_display
	end
	if flr(milliseconds_display / 10) == 0 then
		milliseconds_display = "0"..milliseconds_display
	end
end

function draw_time_display()
	rectfill(c_x,c_y,c_x+128,c_y+1+6+4,0)
	print("score",c_x+6,c_y+0,7)
	local length_of_score = #tostr(score)
	print(score,c_x+8+5*4-length_of_score*4,c_y+6,7)
	print("time",c_x+64-(4*4)/2,c_y+0,8)
	print(minutes_display..":"..seconds_display..":"..milliseconds_display,c_x+64-(7*4)/2,c_y+6,7)
end
