if (isRoomCamera) {
	if (state == CS.FOLLOW) {
		state = CS.IDLE;
		debug("AA");
	}
} else {
	if (state == CS.IDLE) {
		state = CS.FOLLOW;
	}
}

if (state == CS.FOLLOW) {
	if (instance_exists(target)) {
		x = target.x;
		y = target.y;
	}
}

if (state == CS.IDLE) {	
	x = ((x div WVIEW) * WVIEW) + .5 * WVIEW;
	y = ((y div HVIEW) * HVIEW) + .5 * HVIEW;
	xPrev = x;
	yPrev = y;
	if (instance_exists(target)) {				
		
		if (!in(target.x, XVIEW, XVIEW + WVIEW)) {
			dir = (target.x < XVIEW) ? LEFT : RIGHT;
			state = CS.TRANSITION_MOVE;
			moveTicks = maxMoveTicks;
		}
		if (!in(target.y, YVIEW, YVIEW + HVIEW)) {
			dir = (target.y < YVIEW) ? UP : DOWN;
			state = CS.TRANSITION_MOVE;
			moveTicks = maxMoveTicks;
		}
	}
}

if (state == CS.TRANSITION_MOVE) {
	moveTicks = max(moveTicks - 1, 0);
	var _r = 1 - (moveTicks / maxMoveTicks);
	if (dir == LEFT) {
		x = xPrev - _r * WVIEW;
		y = yPrev;
	}
	if (dir == RIGHT) {
		x = xPrev + _r * WVIEW;
		y = yPrev;
	}
	if (dir == UP) {
		x = xPrev;
		y = yPrev - _r * HVIEW;
	}
	if (dir == DOWN) {
		x = xPrev;
		y = yPrev + _r * HVIEW;
	}
	
	if (moveTicks == 0) {
		state = CS.IDLE;
	}
}