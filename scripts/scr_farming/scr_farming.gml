#macro T_DRY_SOIL_TL 387
#macro T_DRY_SOIL_T 388
#macro T_DRY_SOIL_TR 389
#macro T_DRY_SOIL_CL 451
#macro T_DRY_SOIL_C 452
#macro T_DRY_SOIL_CR 453
#macro T_DRY_SOIL_BL 515
#macro T_DRY_SOIL_B 516
#macro T_DRY_SOIL_BR 517
#macro T_DRY_TILLED_SOIL_TL		T_DRY_SOIL_TL + 3
#macro T_DRY_TILLED_SOIL_T		T_DRY_SOIL_T + 3
#macro T_DRY_TILLED_SOIL_TR		T_DRY_SOIL_TR + 3
#macro T_DRY_TILLED_SOIL_CL		T_DRY_SOIL_CL + 3
#macro T_DRY_TILLED_SOIL_C		T_DRY_SOIL_C + 3
#macro T_DRY_TILLED_SOIL_CR		T_DRY_SOIL_CR + 3
#macro T_DRY_TILLED_SOIL_BL		T_DRY_SOIL_BL + 3
#macro T_DRY_TILLED_SOIL_B		T_DRY_SOIL_B + 3
#macro T_DRY_TILLED_SOIL_BR		T_DRY_SOIL_BR + 3
#macro T_WET_TILLED_SOIL_TL		T_DRY_SOIL_TL + 6
#macro T_WET_TILLED_SOIL_T		T_DRY_SOIL_T + 6
#macro T_WET_TILLED_SOIL_TR		T_DRY_SOIL_TR + 6
#macro T_WET_TILLED_SOIL_CL		T_DRY_SOIL_CL + 6
#macro T_WET_TILLED_SOIL_C		T_DRY_SOIL_C + 6
#macro T_WET_TILLED_SOIL_CR		T_DRY_SOIL_CR + 6
#macro T_WET_TILLED_SOIL_BL		T_DRY_SOIL_BL + 6
#macro T_WET_TILLED_SOIL_B		T_DRY_SOIL_B + 6
#macro T_WET_TILLED_SOIL_BR		T_DRY_SOIL_BR + 6

function is_dry_tilled_tile(_tile) {
	switch (_tile) {
		case T_DRY_TILLED_SOIL_TL:
		case T_DRY_TILLED_SOIL_T:
		case T_DRY_TILLED_SOIL_TR:
		case T_DRY_TILLED_SOIL_CL:
		case T_DRY_TILLED_SOIL_C:
		case T_DRY_TILLED_SOIL_CR:
		case T_DRY_TILLED_SOIL_BL:
		case T_DRY_TILLED_SOIL_B:
		case T_DRY_TILLED_SOIL_BR:
			return true;
		default:
			return false;
	}
}

function is_wet_tilled_tile(_tile) {
	switch (_tile) {
		case T_WET_TILLED_SOIL_TL:
		case T_WET_TILLED_SOIL_T:
		case T_WET_TILLED_SOIL_TR:
		case T_WET_TILLED_SOIL_CL:
		case T_WET_TILLED_SOIL_C:
		case T_WET_TILLED_SOIL_CR:
		case T_WET_TILLED_SOIL_BL:
		case T_WET_TILLED_SOIL_B:
		case T_WET_TILLED_SOIL_BR:
			return true;
		default:
			return false;
	}
}

function is_tilled_tile(_tile) {
	return is_dry_tilled_tile(_tile) || is_wet_tilled_tile(_tile);
}

function get_till_tile_at_cell(_cell_x, _cell_y) {
	return tile_get_index(tilemap_get(obj_level_control.tilemap_till, _cell_x, _cell_y));
}

function set_till_border_tile(_cell_x, _cell_y) {
	var _w = room_width div T;
	var _h = room_height div T;
	if (_cell_x < 0 || _cell_y < 0 || _cell_x >= _w || _cell_y >= _h) return;

	var _current = get_till_tile_at_cell(_cell_x, _cell_y);
	if (!is_tilled_tile(_current)) return;

	var _wet = is_wet_tilled_tile(_current);
	var _left = (_cell_x > 0) && is_tilled_tile(get_till_tile_at_cell(_cell_x - 1, _cell_y));
	var _right = (_cell_x < _w - 1) && is_tilled_tile(get_till_tile_at_cell(_cell_x + 1, _cell_y));
	var _up = (_cell_y > 0) && is_tilled_tile(get_till_tile_at_cell(_cell_x, _cell_y - 1));
	var _down = (_cell_y < _h - 1) && is_tilled_tile(get_till_tile_at_cell(_cell_x, _cell_y + 1));

	var _tile = _wet ? T_WET_TILLED_SOIL_C : T_DRY_TILLED_SOIL_C;

	// No inner corners: use center tile for all fully enclosed cases.
	if (!_up && !_left) {
		_tile = _wet ? T_WET_TILLED_SOIL_TL : T_DRY_TILLED_SOIL_TL;
	} else if (!_up && !_right) {
		_tile = _wet ? T_WET_TILLED_SOIL_TR : T_DRY_TILLED_SOIL_TR;
	} else if (!_down && !_left) {
		_tile = _wet ? T_WET_TILLED_SOIL_BL : T_DRY_TILLED_SOIL_BL;
	} else if (!_down && !_right) {
		_tile = _wet ? T_WET_TILLED_SOIL_BR : T_DRY_TILLED_SOIL_BR;
	} else if (!_up) {
		_tile = _wet ? T_WET_TILLED_SOIL_T : T_DRY_TILLED_SOIL_T;
	} else if (!_down) {
		_tile = _wet ? T_WET_TILLED_SOIL_B : T_DRY_TILLED_SOIL_B;
	} else if (!_left) {
		_tile = _wet ? T_WET_TILLED_SOIL_CL : T_DRY_TILLED_SOIL_CL;
	} else if (!_right) {
		_tile = _wet ? T_WET_TILLED_SOIL_CR : T_DRY_TILLED_SOIL_CR;
	}

	tilemap_set(obj_level_control.tilemap_till, _tile, _cell_x, _cell_y);
}

function update_till_borders_around(_cell_x, _cell_y, _cell_w, _cell_h) {
	for (var _x = _cell_x - 1; _x <= _cell_x + _cell_w; _x++) {
		for (var _y = _cell_y - 1; _y <= _cell_y + _cell_h; _y++) {
			set_till_border_tile(_x, _y);
		}
	}
}

// checks (_x, _y)-(_x + 1, _y + 1)
function check_if_can_till(_x, _y) {

	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _px = _x + _i;
			var _py = _y + _j;
			var _t_bg = get_tile_at(_px, _py, "BG");
			var _t_bg_type = get_tile_type(obj_level_control.map_tiles_json, _t_bg);
			var _cell_x = _px div T;
			var _cell_y = _py div T;
			var _t_till = get_till_tile_at_cell(_cell_x, _cell_y);

			if (_t_bg_type != "dry_soil") return false;
			if (is_tilled_tile(_t_till)) return false;

			var _t_fg = get_tile_at(_px, _py, "FG");
			if (_t_fg != 0) return false;
			
			if (position_meeting(_px, _py, obj_harvestable)) return false;

			// TODO: check objects
			
		}
	}

	return true;
}

// places soil at (_x, _y)-(_x + 1, _y + 1)
function till_soil(_x, _y) {
	var _base_cell_x = _x div T;
	var _base_cell_y = _y div T;

	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _cell_x = _base_cell_x + _i;
			var _cell_y = _base_cell_y + _j;

			tilemap_set(obj_level_control.tilemap_till, T_DRY_TILLED_SOIL_C, _cell_x, _cell_y);
		}
	}

	update_till_borders_around(_base_cell_x, _base_cell_y, 2, 2);
}

function check_if_can_untill(_x, _y) {
	var _base_cell_x = _x div T;
	var _base_cell_y = _y div T;

	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _cell_x = _base_cell_x + _i;
			var _cell_y = _base_cell_y + _j;
			var _tile = get_till_tile_at_cell(_cell_x, _cell_y);

			if (!is_tilled_tile(_tile)) return false;
		}
	}
	return true;
}

function untill_soil(_x, _y) {
	var _base_cell_x = _x div T;
	var _base_cell_y = _y div T;

	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _cell_x = _base_cell_x + _i;
			var _cell_y = _base_cell_y + _j;

			tilemap_set(obj_level_control.tilemap_till, 0, _cell_x, _cell_y);
		}
	}

	update_till_borders_around(_base_cell_x, _base_cell_y, 2, 2);
}

function check_if_can_water(_x, _y) {
	var _base_cell_x = _x div T;
	var _base_cell_y = _y div T;

	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _cell_x = _base_cell_x + _i;
			var _cell_y = _base_cell_y + _j;
			var _tile = get_till_tile_at_cell(_cell_x, _cell_y);

			// Can water only dry tilled soil (not empty and not already wet).
			if (!is_dry_tilled_tile(_tile)) return false;
		}
	}

	return true;
}

function water_tilled_soil(_x, _y) {
	var _base_cell_x = _x div T;
	var _base_cell_y = _y div T;

	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _cell_x = _base_cell_x + _i;
			var _cell_y = _base_cell_y + _j;

			tilemap_set(obj_level_control.tilemap_till, T_WET_TILLED_SOIL_C, _cell_x, _cell_y);
		}
	}

	update_till_borders_around(_base_cell_x, _base_cell_y, 2, 2);
}

function get_harvestables_in_proximity(_x, _y, _dir, _radius, _angSpread) {
	var _res = [];
	var _minAngle = 0;
	var _maxAngle = 0;
	if (_dir == UP) {
		_minAngle = 0;
	}
	if (_dir == DOWN) {
		_minAngle = 180;
	}
	if (_dir == LEFT) {
		_minAngle = 90;
	}
	if (_dir == RIGHT) {
		_minAngle = 270;
	}
	
	_maxAngle = _minAngle + _angSpread;
	
	for (var _i = _minAngle; _i <= _maxAngle; _i += 5) {
		var _xo = _x + lengthdir_x(_radius, _i);
		var _yo = _y + lengthdir_y(_radius, _i);
		
		var _harvestable = collision_point(_xo, _yo, obj_harvestable, false, true);
		if (instance_exists(_harvestable) && _harvestable.state == HarvestableState.IDLE) {
			if (!array_find(_res, _harvestable)) {
				array_push(_res, _harvestable);
			}
		}
	}
	
	return _res;
}