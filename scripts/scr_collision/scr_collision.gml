function player_check_collision(_self, _x_off, _y_off) {
	
	var _x = [_self.bbox_left, _self.x, _self.bbox_right];
	var _y = [_self.bbox_top, _self.y, _self.bbox_bottom];
	
	for (var _i = 0; _i < array_length(_x); _i++) {
		for (var _j = 0; _j < array_length(_y); _j++) {
			var _tile_fg = get_tile_at(_x[_i] + _x_off, _y[_j] + _y_off, "FG");
			if (_tile_fg != 0) return true;
		}
	}
		
	/*var _harvestable = collision_rectangle(bbox_left + _x_off, bbox_top + _y_off, bbox_right + _x_off, bbox_bottom + _y_off, obj_harvestable, false, true);
	if (instance_exists(_harvestable) && _harvestable.state == HState.IDLE) {
		if (_harvestable.type != HType.GRASS) {
			return true;
		}
	}*/
	
	var _col = false;
	var _list = ds_list_create();
	var _count = collision_rectangle_list(bbox_left + _x_off, bbox_top + _y_off, bbox_right + _x_off, bbox_bottom + _y_off, obj_harvestable, false, true, _list, false);

	for (var _j = 0; _j < _count; _j++) {
		var _h = _list[| _j];
		if (!instance_exists(_h)) continue;
		if (_h.state != HState.IDLE) continue;
		if (_h.type == HType.GRASS) continue;

		_col = true;
		break;
	}

	ds_list_destroy(_list);
	return _col;
}