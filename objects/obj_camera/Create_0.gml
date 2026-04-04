enum CS {
	IDLE,
	FOLLOW,
	TRANSITION_MOVE,
	TRANSITION_FADE_IN,
	TRANSITION_FADE_OUT
}

isRoomCamera = true;

state = CS.IDLE;
target = noone;
dir = NONE;
moveTicks = 0;
maxMoveTicks = 60;
xPrev = x;
yPrev = y;