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
var _a = animation_for_direction(anim, dir);
animation_update(self, _a);