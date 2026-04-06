//draw_self();

draw_sprite(spr_shadow, -1, x, bbox_bottom);

var _a = animation_for_direction(anim, dir);
animation_draw(_a, dir == RIGHT ? -1 : 1, 1);

//draw_rectangle(target_tile_x, target_tile_y, target_tile_x + TT, target_tile_y + 16, 1);


if (state == PS.USE_TOOL) {
	var _tx = 0;
	var _ty = 0;

	if (dir == DOWN) _ty = 0;
	if (dir == UP) _ty = 1;
	if (dir == LEFT || dir == RIGHT) _ty = 2;
	
	_tx = _a.f_frame;
	var _ti = 0;
	switch(tools[toolIndex]) {
		case Tool.HOE: 
			_ti = 0; 
		break;
		case Tool.WATERING_CAN: 
			_ti = 1;
		break;
		case Tool.AXE:
			_ti = 2;
		break;		
	}
	
	draw_sprite_part_ext(spr_tools, -1, _tx * 32 + _ti * 128, _ty * 32, 32, 32, x - 16 + (dir == RIGHT) * 32, y - 16, dir == RIGHT ? -1 : 1, 1, c_white, 1);
}