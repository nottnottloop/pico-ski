function update_camera()
	c_x = p_x-63+8+c_jerk_x
	c_y = p_y-120+8+c_jerk_y
	camera(c_x,c_y)
end

function debug_local_file_save(obj, fields, name)
	printh(nil, name, true)
	for i=1,#fields do
		printh(obj[fields[i]], name, false)
	end
end