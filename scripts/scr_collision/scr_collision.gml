function check_collision(_self, _x_off, _y_off) {
	//if (collision_rectangle()
	var _tile_fg = get_tile_at(_self.x + _x_off, _self.y + _y_off, "FG");
	
	return _tile_fg != 0;
}