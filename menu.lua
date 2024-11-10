function menu_update()
	reset_camera()
	if (btnp(🅾️)) then
		level_1_init()
		game_state = "level_1"
	end
end

function menu_draw()
	cls()
	draw_hud(false)
end