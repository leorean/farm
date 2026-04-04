enum PS {
	IDLE =		1 << 0,
	WALK =		1 << 1
}

state = PS.IDLE;
dir = DOWN;

k_up = false;
k_down = false;
k_left = false;
k_right = false;
k_action1 = false;
k_action2 = false;

xVel = 0;
yVel = 0;
zVel = 0;
zGrav = .1;
z = 0;

push_power = 0;