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

function check_collisions()
	colliding = false
	-- obstacles
	for i=1, #obstacles_table do
		if (p_x+2)<obstacles_table[i].x+16 and ((p_x+2)+12)>obstacles_table[i].x and (p_y)<obstacles_table[i].y+16 and (p_y+16)>obstacles_table[i].y then
			collide()
		end
	end

	-- boundary trees
	if (p_x+2)<(5*16)-tree_offset or (p_x+14)>(-4*16)+tree_offset then		
		collide()
	end
end

function collide()
	--sfx(0)
	colliding = true
end

function generate_obstacles()
	--add(obstacles_table,{sprite=5,x=0,y=0})
	for i=1,amount_of_obstacles do
		local sprite = 5 + flr(rnd(3))*2
		local rand_x = flr(rnd((-160)+tree_offset*2))-tree_offset+80
		local rand_y = -flr(rnd(length_of_level-300))-300
		add(obstacles_table,{sprite=sprite,x=rand_x,y=rand_y})
	end
end

function update_camera()
	c_x = p_x-63+8
	c_y = p_y-120+8
	camera(c_x,c_y)
end

function draw_boundary_trees()
	if (flr(p_y) % 80 < 3) tree_checkpoint = p_y
	for i=-10,20 do
		for j=0,4 do
			spr(3,(j*16)-tree_offset,tree_checkpoint+80-(i*16),2,2)
			spr(3,(-j*16)+tree_offset,tree_checkpoint+80-(i*16),2,2)
		end
	end
end

function debug_print()
	if draw_debug_print then
		print(p_x.." "..p_y,33+c_x,50+c_y)
		print(acceleration,33+c_x,63+c_y)
		print(speed)
		pset(p_x,p_y,10)
		if colliding then
			print("colliding!",15+c_x,93+c_y)
		end
		print("cpu: "..stat(1),c_x,116+c_y)
		print("memory: "..stat(0),c_x,122+c_y)
	end
end