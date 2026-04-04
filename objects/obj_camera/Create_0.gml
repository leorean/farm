enum CS {
	IDLE,
	FOLLOW,
	TRANSITION_MOVE,
	TRANSITION_FADE_IN,
	TRANSITION_FADE_OUT
}

isRoomCamera = false;

state = isRoomCamera ? CS.IDLE : CS.FOLLOW;
target = noone;
dir = NONE;
moveTicks = 0;
maxMoveTicks = 40;
xPrev = x;
yPrev = y;

// need to set the view position once
camera_set_view_pos(view_camera[0], x, y);