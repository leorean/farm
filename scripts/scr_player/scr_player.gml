function player_get_harvestables_for_sword(_x, _y, _dir) {
	var _dx = [];
	var _dy = [];
	if (_dir == UP) {
		_dx = [0, 1, 1, 0];
		_dy = [0, 0, -1, -1];
	} else if (_dir == DOWN) {
		_dx = [0, -1, -1, 0];
		_dy = [0, 0, 1, 1];
	} else if (_dir == LEFT) {
		_dx = [0, 0, -1, -1];
		_dy = [0, -1, -1, 0];
	} else if (_dir == RIGHT) {
		_dx = [0, 0, 1, 1];
		_dy = [0, -1, -1, 0];
	}

	var _harvestables = [];
	var _seen = ds_map_create();
	for (var _i = 0; _i < 4; _i++) {
		var _tx = _x + _dx[_i] * 12;
		var _ty = _y + _dy[_i] * 12;
		var _list = ds_list_create();
		var _count = collision_rectangle_list(_tx - 6, _ty - 6, _tx + 6, _ty + 6, obj_harvestable, false, true, _list, false);

		for (var _j = 0; _j < _count; _j++) {
			var _h = _list[| _j];
			if (!instance_exists(_h)) continue;
			if (_h.state != HState.IDLE) continue;

			var _key = string(_h);
			if (!ds_map_exists(_seen, _key)) {
				ds_map_add(_seen, _key, true);
				array_push(_harvestables, _h);
			}
		}

		ds_list_destroy(_list);
	}
	ds_map_destroy(_seen);
	return _harvestables;
}

function player_get_harvestables_for_scythe(_x, _y, _dir) {
	var _dx = [];
	var _dy = [];
	if (_dir == UP) {
		_dx = [0, -1, -1, 0, 1, 1];
		_dy = [0, 0, -1, -1, -1, 0];
	} else if (_dir == DOWN) {
		_dx = [0, -1, -1, 0, 1, 1];
		_dy = [0, 0, 1, 1, 1, 0];
	} else if (_dir == LEFT) {
		_dx = [0, 0, -1, -1, -1, 0];
		_dy = [0, -1, -1, 0, 1, 1];
	} else if (_dir == RIGHT) {
		_dx = [0, 0, 1, 1, 1, 0];
		_dy = [0, -1, -1, 0, 1, 1];
	}

	var _harvestables = [];
	var _seen = ds_map_create();
	for (var _i = 0; _i < 6; _i++) {
		var _tx = _x + _dx[_i] * 12;
		var _ty = _y + _dy[_i] * 12;
		var _list = ds_list_create();
		var _count = collision_rectangle_list(_tx - 6, _ty - 6, _tx + 6, _ty + 6, obj_harvestable, false, true, _list, false);

		for (var _j = 0; _j < _count; _j++) {
			var _h = _list[| _j];
			if (!instance_exists(_h)) continue;
			if (_h.state != HState.IDLE) continue;

			var _key = string(_h);
			if (!ds_map_exists(_seen, _key)) {
				ds_map_add(_seen, _key, true);
				array_push(_harvestables, _h);
			}
		}

		ds_list_destroy(_list);
	}
	ds_map_destroy(_seen);
	return _harvestables;
}

function player_get_damage_for_tool(_t, _level) {
	switch(_t) {
		case Tool.AXE:
			if (_level == 0) return 1;
			if (_level == 1) return 2;
			if (_level == 2) return 3;
			if (_level == 3) return 4;
		break;
		case Tool.PICKAXE:
			if (_level == 0) return 1;
			if (_level == 1) return 2;
			if (_level == 2) return 3;
			if (_level == 3) return 4;
		break;
		case Tool.SWORD:
			if (_level == 0) return 1;
			if (_level == 1) return 2;
			if (_level == 2) return 3;
			if (_level == 3) return 4;
		break;
		default:
			return 1;
	}
	throw string("Level not {0} implemented for tool {1}", _level, _t);
}