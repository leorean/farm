//draw_self();

draw_sprite(spr_shadow, -1, x, bbox_bottom);

var _a = animation_for_direction(anim, dir);
animation_draw(_a, dir == RIGHT ? -1 : 1, 1);

//draw_rectangle(target_tile_x, target_tile_y, target_tile_x + TT, target_tile_y + 16, 1);


if (has_flag(state, PS.USE_TOOL | PS.ATTACK | PS.TOOL_BOUNCE)) {
	var _tx = 0;
	var _ty = 0;
	var _xo = 0;
	var _yo = 0;

	if (dir == DOWN) _ty = 0;
	if (dir == UP) _ty = 1;
	if (dir == LEFT || dir == RIGHT) _ty = 2;
	
	_tx = _a.f_frame;
	
	// special offsets for sword
	if (tools[toolIndex].type == Tool.SWORD) {		
		if (dir == UP || dir == DOWN) {
			if (_a.f_frame == 0) {
				_xo = -sign(dir) * 4;
			}
			if (_a.f_frame == 1) {
				_xo = -sign(dir) * 2;
				_yo = sign(dir) * 2;
			}
			if (_a.f_frame == 2) {
				_yo = sign(dir) * 6;
			}
			if (_a.f_frame == 3) {
				_yo = sign(dir) * 4;
			}
		}
		if (dir == LEFT || dir == RIGHT) {
			if (_a.f_frame == 0) {
				_yo = -4;
			}
			if (_a.f_frame == 1) {
				_xo = sign(dir) * 2;
			}
			if (_a.f_frame == 2) {
				_xo = sign(dir) * 6;
			}
			if (_a.f_frame == 3) {
				_xo = sign(dir) * 4;
			}
		}
	}
	
	var _ti = tools[toolIndex].type - 1; // -1 because hand is at 0, and has no sprites
	var _tl = tools[toolIndex].level;
	draw_sprite_part_ext(spr_tools, -1, _tx * 32 + _ti * 128, _ty * 32 + _tl * 96, 32, 32, x - 16 + (dir == RIGHT) * 32 + _xo, y - 16 + _yo, dir == RIGHT ? -1 : 1, 1, c_white, 1);
}

//draw_point(cx,cy);