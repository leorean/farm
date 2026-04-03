enum LevelState {
	PLAY,
	PAUSE,
	TRANSITION
}

state = LevelState.PLAY;

layer_bg = -1;
layer_fg = -1;
tilemap_bg = -1;
tilemap_fg = -1;
segments_loaded = [];
player_x = 0;
player_y = 0;

map_tiles_json = map_load_tile_data("tiles.json");

map_json = map_load_from_file("map.json", ts_tiles);
var _seg_in_view_w = (map_json.width * T) / V_WIDTH;
var _seg_in_view_h = (map_json.height * T) / V_HEIGHT;

for (var _x = 0; _x < _seg_in_view_w; _x++) {
	for (var _y = 0; _y < _seg_in_view_h; _y++) {
		map_load_segment(map_json, map_tiles_json, _x, _y);
	}
}

dayTimeCtl = instance_create_depth(0, 0, -900000, obj_daytime_control);