function game_over_update()
	camera()
	game_over_text = "game over"
end

function game_over_draw()
	cls(0)
	print(game_over_text,63-#game_over_text*2,63,10)
end
