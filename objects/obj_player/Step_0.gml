// begin step

if (obj_camera.state != CS.IDLE && obj_camera.state != CS.FOLLOW) return;

// states

if (state == PS.IDLE) {
	xVel = 0;
	yVel = 0;
	if (k_left) {
		dir = LEFT;
		state = PS.WALK;
		anim = animation_set_array(anim_walk);
	}
	if (k_right) {
		dir = RIGHT;
		state = PS.WALK;
		anim = animation_set_array(anim_walk);
	}
	if (k_up) {
		dir = UP;
		state = PS.WALK;
		anim = animation_set_array(anim_walk);
	}
	if (k_down) {
		dir = DOWN;
		state = PS.WALK;
		anim = animation_set_array(anim_walk);
	}
}

if (state == PS.WALK) {
	var _spd = 1;
	if (k_left) {
		if (push_power == 0) dir = LEFT;
		xVel = -_spd;
	} else if (k_right) {
		if (push_power == 0) dir = RIGHT;
		xVel = _spd;
	} else {
		xVel = 0;
	}
	
	if (k_up) {
		if (push_power == 0) dir = UP;
		yVel = -_spd;
	} else if (k_down) {
		if (push_power == 0) dir = DOWN;
		yVel = _spd;
	} else {
		yVel = 0;
	}
	
	if (!k_left && !k_right && !k_up && !k_down) {
		state = PS.IDLE;
		anim = animation_set_array(anim_idle);
	}
}

// tilling / farming

target_tile_x = (x div TT) * TT + sign(dir) * (dir == LEFT || dir == RIGHT) * TT;
target_tile_y = (y div TT) * TT + sign(dir) * (dir == UP || dir == DOWN) * TT;
var _xt = target_tile_x;
var _yt = target_tile_y;
var _toolType = tools[toolIndex];

if (has_flag(state, PS.IDLE | PS.WALK)) {

	if (k_ls_pressed) toolIndex = (toolIndex + array_length(tools) - 1) % array_length(tools);
	if (k_rs_pressed) toolIndex = (toolIndex + 1) % array_length(tools);
	
	if (k_action2_pressed) {
	
		if (_toolType == Tool.HOE) {
			state = PS.USE_TOOL;
			anim = animation_set_array(anim_use_tool);
		}
		
	}
}

if (has_flag(state, PS.USE_TOOL)) {
	xVel = 0;
	yVel = 0;
	var _a = animation_for_direction(anim, dir);

	if (animation_is_done(_a)) {
		if (_toolType == Tool.HOE) {
			if (check_if_can_till(_xt, _yt)) {
				till_soil(_xt, _yt);
			}
		}
	
		if (_toolType == Tool.HAMMER) {
			if(check_if_can_untill(_xt, _yt)) {
				untill_soil(_xt, _yt);
			}	
		}
		
		state = PS.IDLE;
		anim = animation_set_array(anim_idle);
	}
}

// collision & movement

if (!check_collision(self, xVel, 0)) {
	x += xVel;
} else {
	xVel = 0;
}

if (!check_collision(self, 0, yVel)) {
	y += yVel;
} else {
	yVel = 0;
}

// end step
animation_update(self, animation_for_direction(anim, dir));