function animation_create(_sprite, _f_min, _f_count, _f_speed, _loop, _frame_width, _frame_height) {
	var a = instance_create_depth(0, 0, 0, obj_animation);
	
	a.f_min = _f_min;
	a.f_count = _f_count;
	a.f_speed = _f_speed;
	a.f_loop = _loop;
	a.f_sprite = _sprite;
	a.f_width = _frame_width;
	a.f_height = _frame_height;
	a.x = -999;
	a.y = -999;
	
	return a;
}

function animation_create_directions(_sprite, _f_min, _f_count, _f_speed, _loop, _frame_width, _frame_height) {
	var _tw = sprite_get_width(_sprite) / _frame_width;	
	
	var _anims = [];
	var _down = animation_create(_sprite, _f_min + 0 * _tw, _f_count, _f_speed, _loop, _frame_width, _frame_height);
	var _up =	animation_create(_sprite, _f_min + 1 * _tw, _f_count, _f_speed, _loop, _frame_width, _frame_height);
	var _left = animation_create(_sprite, _f_min + 2 * _tw, _f_count, _f_speed, _loop, _frame_width, _frame_height);
	
	array_push(_anims, _down);
	array_push(_anims, _up);
	array_push(_anims, _left);
	
	return _anims;
}

function animation_for_direction(_anim_array, _dir) {
	if (_dir == DOWN) return _anim_array[0];
	if (_dir == UP) return _anim_array[1];
	if (_dir == LEFT) return _anim_array[2];
	if (_dir == RIGHT) return _anim_array[2];
}


function animation_update(_self, _anim) {
	if (!instance_exists(_anim)) return;
	
	_anim.depth = _self.depth;
	_anim.x = _self.x;
	_anim.y = _self.y;
	
	if (_anim.f_loop) {
		_anim.f_cur = (_anim.f_cur + _anim.f_speed) % _anim.f_count;
		_anim.f_frame = floor(_anim.f_cur);
	} else {
		_anim.f_cur = min(_anim.f_cur+ _anim.f_speed, _anim.f_count);
		if (_anim.f_cur == _anim.f_count) _anim.f_is_done = true;
		_anim.f_frame = clamp(floor(_anim.f_cur), 0, _anim.f_count - 1);
	}
}

function animation_draw(_anim, _flipX, _flipY) {	
	if (!instance_exists(_anim)) return;
	
	var _f = _anim.f_min + _anim.f_frame;
	
	var _sprites_per_row = sprite_get_width(_anim.f_sprite) / _anim.f_width;
	var _sprites_per_col = sprite_get_height(_anim.f_sprite) / _anim.f_height;
	
	// ensure last frame isn't empty
	_f = min(_f, _sprites_per_row * _sprites_per_col - 1);
	
	var _xo = (_f % _sprites_per_row) * _anim.f_width;
	var _yo = (_f div _sprites_per_row) * _anim.f_height;

	var _x = floor(_anim.x + _anim.f_width * .5 - (_flipX == 1) * _anim.f_width);
	var _y = floor(_anim.y + _anim.f_height * .5 - (_flipY == 1) * _anim.f_height);
	
	draw_sprite_part_ext(_anim.f_sprite, -1, _xo, _yo, _anim.f_width, _anim.f_height, _x, _y, _flipX, _flipY, c_white, 1);
}

function animation_draw_projected(_anim, _flipX, _flipY, _scr, _z_offset = 0) {	
	if (!instance_exists(_anim)) return;
	
	var _k = _scr.k;
	var _cx = _scr.sx;
	var _cy = _scr.sy + _z_offset;
	
	var _f = _anim.f_min + _anim.f_frame;
	
	var _sprites_per_row = sprite_get_width(_anim.f_sprite) / _anim.f_width;
	var _sprites_per_col = sprite_get_height(_anim.f_sprite) / _anim.f_height;
	
	// ensure last frame isn't empty
	_f = min(_f, _sprites_per_row * _sprites_per_col - 1);
	
	var _xo = (_f % _sprites_per_row) * _anim.f_width;
	var _yo = (_f div _sprites_per_row) * _anim.f_height;

	var _x = floor(_cx + _anim.f_width * _k * .5 - (_flipX == 1) * _anim.f_width * _k);
	var _y = floor(_cy + _anim.f_height * _k * .5 - (_flipY == 1) * _anim.f_height * _k);
	
	draw_sprite_part_ext(_anim.f_sprite, -1, _xo, _yo, _anim.f_width, _anim.f_height, _x, _y, _flipX * _k, _flipY * _k, c_white, 1);
}

function animation_set(_anim_new) {
	animation_reset(_anim_new);
	return _anim_new;
}

function animation_set_array(_anim_new) {
	animation_reset(_anim_new[0]);
	animation_reset(_anim_new[1]);
	animation_reset(_anim_new[2]);
	return _anim_new;
}

function animation_reset(_anim) {
	if (!instance_exists(_anim)) return;
	
	_anim.f_cur = 0;
	_anim.f_is_done = false;
}

function animation_end(_anim) {
	_anim.f_cur = _anim.f_max;
	_anim.f_is_done = true;
}

function animation_set_frame(_anim, _frame) {
	_anim.f_cur = min(_frame, _anim.f_max);
	if (_anim.f_cur == _anim.f_max) {
		_anim.f_is_done = true;
	}
}

function animation_is_done(_anim) {
	if (!instance_exists(_anim)) return false;
	
	return _anim.f_is_done;
}