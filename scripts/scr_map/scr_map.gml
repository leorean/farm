function map_load_from_file(_file, _tileset) {
	
	// step 1: get data into json
	var _json = json_decode("{}");	
	var _content = "";	
	var _file_buffer = buffer_load(_file);
	_content = string(buffer_read(_file_buffer, buffer_string));
	buffer_delete(_file_buffer);
	_content = minify_and_sanitize_string(_content);
	_json = json_parse(_content);
	
	var _w = real(_json.width);
	var _h = real(_json.height);
	room_width = _w * T;
	room_height = _h * T;
		
	// step 2: prepare layers
	layer_bg = layer_create(L_BG, "BG");
	layer_fg = layer_create(L_FG, "FG");
	tilemap_bg = layer_tilemap_create(layer_bg, 0, 0, _tileset, _w, _h);
	tilemap_fg = layer_tilemap_create(layer_fg, 0, 0, _tileset, _w, _h);
	
	// step 3: prepare layer data in 2D
	var _layers = _json.layers;
	for(var _l = 0; _l < array_length(_layers); _l++) {
		var _lay = _layers[_l];
		if (variable_struct_exists(_lay, "data")) {
			var _2d_data = array_1d_to_2d(_lay.data, _w);
			_layers[_l].data_2d = _2d_data;
		}
	}
	
	if (variable_struct_exists(_json, "properties")) {
		var _props = _json.properties;
		for (var _i = 0; _i < array_length(_props); _i++) {
			var _p = _props[_i];
			if (_p.name == "player_start_x") {
				player_start_x = _p.value;
			}
			if (_p.name == "player_start_y") {
				player_start_y = _p.value;
			}
		}
	}
	
	return _json;
}

function map_load_tile_data(_file) {
	var _json = json_decode("{}");	
	var _content = "";	
	var _file_buffer = buffer_load(_file);
	_content = string(buffer_read(_file_buffer, buffer_string));
	buffer_delete(_file_buffer);
	_content = minify_and_sanitize_string(_content);
	_json = json_parse(_content);
	
	return _json.tiles;
}

function map_load_segment(_json, _tile_json, _seg_x_in_views, _seg_y_in_views) {
	
	var _t = T;
	
	// seg_x, seg_y are in TILES
	var _seg_x = _seg_x_in_views * (V_WIDTH div _t)
	var _seg_y = _seg_y_in_views * (V_HEIGHT div _t);
	
	var _seg_id = $"{_seg_x}_{_seg_y}";
	
	if (array_find(segments_loaded, _seg_id)) {
		debug ($"segment {_seg_id} already loaded");
		return;
	}
	
	array_push(segments_loaded, _seg_id);

	var _seg_x_in_pixels = _seg_x * V_WIDTH;
	var _seg_y_in_pixels = _seg_y * V_HEIGHT;
	var _seg_x_in_tiles = _seg_x * _t;
	var _seg_y_in_tiles = _seg_y * _t;
	
	var _layers = _json.layers;

	// step 4: create tiles & objects
	for(var _l = 0; _l < array_length(_layers); _l++) {
		var _lay = _layers[_l];
		var _name = _lay.name;
				
		// objects (coded)
		if (_name == "objects") {			
			var _data = _lay.objects;
			for (var _i = 0; _i < array_length(_data); _i++) {
				var _x = _data[_i].x;
				var _y = _data[_i].y;
				
				if (_x < _seg_x_in_tiles || _x > _seg_x_in_tiles + V_WIDTH
					|| _y < _seg_y_in_tiles || _y > _seg_y_in_tiles + V_HEIGHT) {						
					continue;
				}
				
				var _type = _data[_i].type;
				var _props = variable_instance_exists(_data[_i], "properties") ? _data[_i].properties : undefined;
				
				switch(_type) {
					case "player":
						{
							player_x = _x + .5 * T;
							player_y = _y + .5 * T;
						}
					break;
					case "door":
						{
							/*var _target_map = get_prop(_props, "target_map");
							var _target_map_x = get_prop(_props, "target_map_x");
							var _target_map_y = get_prop(_props, "target_map_y");
							var _target_map_dir = get_prop(_props, "target_map_dir");
							var _continue_bgm = get_prop(_props, "continue_bgm", false);
							if (string_lower(_target_map_dir) == "up") _target_map_dir = UP;
							if (string_lower(_target_map_dir) == "down") _target_map_dir = DOWN;
							if (string_lower(_target_map_dir) == "left") _target_map_dir = LEFT;
							if (string_lower(_target_map_dir) == "right") _target_map_dir = RIGHT;
							var _door = instance_create_depth(_x + 8, _y + 8, L_OBJ, obj_door, 
								{
									target_map: _target_map, 
									target_map_x: _target_map_x, 
									target_map_y: _target_map_y, 
									target_map_dir: _target_map_dir, 
									continue_bgm: _continue_bgm
								});*/
						}
						break;
					default:
						break;					
				}
			}
		}
		
		// BG
		if (_name == "BG") {
			var _data = _lay.data_2d;			
			for (var _i = _seg_x; _i < _seg_x + (V_WIDTH div _t); _i++) {
				for (var _j = _seg_y; _j < _seg_y + (V_HEIGHT div _t); _j++) {
					var _tile = real(_data[_j][_i]) - 1;
				
					if (_tile < 1)
						continue;
					
					var _x = _i * _t;
					var _y = _j * _t;					
					
					tilemap_set(tilemap_bg, _tile, _x div _t, _y div _t);
					
					var _type = get_tile_type(_tile_json, _tile);
					
					if (_type == "water") {
						//instance_create_depth(_x, _y, L_OBJ, obj_water);
					}
				}
			}
		}
		
		// FG
		if (_name == "FG") {
			var _data = _lay.data_2d;
			for (var _i = _seg_x; _i < _seg_x + (V_WIDTH div _t); _i++) {
				for (var _j = _seg_y; _j < _seg_y + (V_HEIGHT div _t); _j++) {

					var _tile = real(_data[_j][_i]) - 1;
				
					if (_tile < 1)
						continue;					
					
					var _x = _i * _t;
					var _y = _j * _t;
					
					tilemap_set(tilemap_fg, _tile, _x div _t, _y div _t);
					
					var _type = get_tile_type(_tile_json, _tile);
										
					//if (_type == "noblock") {
					//	tilemap_set(tilemap_fg, _tile, _x div 8, _y div 8);
					//} else if (_type == "climb") {
					//	tilemap_set(tilemap_fg, _tile, _x div 8, _y div 8);
					//	instance_create_depth(_x + 4, _y, L_OBJ, obj_climb);
					//	instance_create_depth(_x, _y, L_OBJ, obj_solid);
					//	//instance_create_depth(_x, _y, L_OBJ, obj_solid);
					//} else if (_type == "spike") {
					//	//tilemap_set(tilemap_fg, _tile, _x div T, _y div T);
					//	//instance_create_depth(_x + 4, _y + 4, L_FG, obj_spike);
					//} else {
					//	tilemap_set(tilemap_fg, _tile, _x div 8, _y div 8);
					//	if (_type != "noblock") {
					//		instance_create_depth(_x, _y, L_OBJ, obj_solid);
					//	}
					//}
				}
			}
		}		
		
		// OBJ
		if (_name == "OBJ") {
			var _data = _lay.data_2d;
			for (var _i = _seg_x; _i < _seg_x + (V_WIDTH div _t); _i++) {
				for (var _j = _seg_y; _j < _seg_y + (V_HEIGHT div _t); _j++) {

					var _tile = real(_data[_j][_i]) - 1;
				
					if (_tile < 0)
						continue;					
					
					var _x = _i * _t;
					var _y = _j * _t;

					var _type = get_tile_type(_tile_json, _tile);
					
					//if (_type == "grass") {
//						instance_create_depth(_x + 8, _y + 8, L_BG - 1, obj_grass, {tile: _tile});
					//}

					// hard-coded values:
					switch(_tile) {
						case 0: //
							//instance_create_depth(_x, _y, L_OBJ, obj_player);
							break;
						case 2:
							instance_create_depth(_x + T, _y + T, L_EFFECTS, obj_light);
							break;
						default:
							break;
					}
				}
			}
		}
	}	
}

function load_adjacent_segments(_json, _tile_json, _x, _y) {
	for (var _i = -1; _i < 2; _i++) {
		for (var _j = -1; _j < 2; _j++) {
			var _seg_x = (_x div V_WIDTH) + _i;
			var _seg_y = (_y div V_HEIGHT) + _j;
				
			// ignore out of bounds sections
			if (_seg_x < 0 
			|| _seg_y < 0 
			|| _seg_x >= (room_width div V_WIDTH)
			|| _seg_y >= (room_height div V_HEIGHT)) {
				continue;
			}
				
			map_load_segment(_json, _tile_json, _seg_x, _seg_y);
		}
	}
}

function get_prop(_arr, _k, _default_val) {
	for(var _i = 0; _i < array_length(_arr); _i++) {
		if (_arr[_i].name == _k) {
			return _arr[_i].value;
		}
	}
	
	if (!is_undefined(_default_val)) {
		return _default_val;
	}
	
	throw ("key not found");
}

function array_1d_to_2d(_arr, _w) {	
	var _res = [];	
	var _rows = array_length(_arr) div _w;
	for (var _i = 0; _i < _rows; _i++) {
		var _row = array_create(_w, -1);
		array_copy(_row, 0, _arr, _i * _w, _w);
		array_push(_res, _row);
	}
	return _res;
}

function minify_and_sanitize_string(_str) {
	_str = string_replace_all(_str, @'\n', @"");
	_str = string_replace_all(_str, @'\t', @"");
	return _str;
}

function get_tile_at(_x, _y, _layer) {
	var _map_id = layer_tilemap_get_id(layer_get_id(_layer));
	var _mx = tilemap_get_cell_x_at_pixel(_map_id, _x, _y);
	var _my = tilemap_get_cell_y_at_pixel(_map_id, _x, _y);
	var _data = tilemap_get(_map_id, _mx, _my);
	var _ind = tile_get_index(_data);
	return _ind;
}

function get_tile_type(_json, _tile) {
	
	for (var _i = 0; _i < array_length(_json); _i++) {
		var _tile_data = _json[_i];
		if (variable_instance_exists(_tile_data, "type") && _tile_data.id == _tile) {
			return _tile_data.type;
		}
	}
	return "";
}