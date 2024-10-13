function move_skier()
	if (btn(⬅️)) p_x-=speed
	if (btn(➡️)) p_x+=speed
	if (btn(⬇️)) p_y+=speed
	if (btn(⬆️)) p_y-=speed
end