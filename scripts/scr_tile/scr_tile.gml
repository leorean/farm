#macro T_DRY_SOIL_TL 387
#macro T_DRY_SOIL_T 388
#macro T_DRY_SOIL_TR 389
#macro T_DRY_SOIL_CL 451
#macro T_DRY_SOIL_C 452
#macro T_DRY_SOIL_CR 453
#macro T_DRY_SOIL_BL 515
#macro T_DRY_SOIL_B 516
#macro T_DRY_SOIL_BR 517




// checks (_x, _y)-(_x + 1, _y + 1)
function check_if_can_till(_x, _y) {
	
	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _t_bg = get_tile_at(_x + _i, _y + _j, "BG");
			var _t_bg_type = get_tile_type(obj_level_control.map_tiles_json, _t_bg);
			
			if (_t_bg_type != "tillable") return false;
			
			// TODO: check objects
		}
	}
	
	return true;
}

// places soil at (_x, _y)-(_x + 1, _y + 1)
function till_soil(_x, _y) {
	
	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _cell_x = (_x div T) + _i;
			var _cell_y = (_y div T) + _j;

			tilemap_set(obj_level_control.tilemap_till, T_DRY_SOIL_C, _cell_x, _cell_y);
		}
	}
	
	// TODO: update all border tiles in proximity
}