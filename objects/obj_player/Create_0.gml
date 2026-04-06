enum Tool {
	HAND,
	HOE,
	WATERING_CAN,
	AXE,
	HAMMER,
	SCYTHE,
	PICKAXE,
	SWORD
}

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
k_action2_pressed = false;
k_ls_pressed = false;
k_rs_pressed = false;

xVel = 0;
yVel = 0;
zVel = 0;
zGrav = .1;
z = 0;

push_power = 0;

// TT precision
target_tile_x = 0;
target_tile_y = 0;

tools = [
	Tool.HAND,
	Tool.HOE,
	Tool.WATERING_CAN,
	Tool.AXE,
	Tool.HAMMER,
	Tool.SCYTHE,
	Tool.PICKAXE,
	Tool.SWORD
];
toolIndex = 0;


create_light(x, y, 40, false, 1.0, self);

anim_idle =		animation_create_directions(spr_player, 0, 1, .0, false, 24, 24);
anim_walk =		animation_create_directions(spr_player, 1, 4, .15, true, 24, 24);

anim = anim_idle;