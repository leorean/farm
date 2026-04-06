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




// checks (_x, _y)-(_x + 1, _y + 1)
function check_if_can_till(_x, _y) {
	
	for (var _i = 0; _i < 2; _i++) {
		for (var _j = 0; _j < 2; _j++) {
			var _t_bg = get_tile_at(_x + _i, _y + _j, "BG");
			var _t_bg_type = get_tile_type(obj_level_control.map_tiles_json, _t_bg);
			
			if (_t_bg_type != "dry_soil") return false;
			
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

			tilemap_set(obj_level_control.tilemap_till, T_DRY_TILLED_SOIL_C, _cell_x, _cell_y);
		}
	}
	
	// TODO: update all border tiles in proximity
}