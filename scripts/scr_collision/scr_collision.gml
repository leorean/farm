function check_collision(_self, _x_off, _y_off) {
	//if (collision_rectangle()
	
	var _x = [_self.bbox_left, _self.x, _self.bbox_right];
	var _y = [_self.bbox_top, _self.y, _self.bbox_bottom];
	
	for (var _i = 0; _i < array_length(_x); _i++) {
		for (var _j = 0; _j < array_length(_y); _j++) {
			var _tile_fg = get_tile_at(_x[_i] + _x_off, _y[_j] + _y_off, "FG");
			if (_tile_fg != 0) return true;
		}
	}
	
	return false;
	//var _tile_fg = get_tile_at(_self.x + _x_off, _self.y + _y_off, "FG");
	
	//return _tile_fg != 0;
}