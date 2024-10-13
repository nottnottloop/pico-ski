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
	print(score,c_x+2+5*4,c_y+6,7)
	--print("time",c_x+64-(4*4)/2,c_y+0,8)
	--print(minutes_display..":"..seconds_display..":"..milliseconds_display,c_x+64-(7*4)/2,c_y+6,7)
end

function check_collisions(x_coord,y_coord)
	-- boundary trees
	if (p_x+2)<(5*16)-tree_offset or (p_x+14)>(-4*16)+tree_offset then		
		collide()
	end
end

function collide()
	sfx(0)
end

function update_camera()
	c_x = p_x-63+8
	c_y = p_y-63+8
	camera(c_x,c_y)
end

function draw_boundary_trees()
	if (p_y % 80 == 0) tree_checkpoint = p_y
	for i=-10,20 do
		for j=0,4 do
			spr(3,(j*16)-tree_offset,tree_checkpoint+80-(i*16),2,2)
			spr(3,(-j*16)+tree_offset,tree_checkpoint+80-(i*16),2,2)
		end
	end
end