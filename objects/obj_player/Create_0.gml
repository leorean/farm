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
	IDLE =			1 << 0,
	WALK =			1 << 1,
	ATTACK =		1 << 2,
	USE_TOOL =		1 << 3,
	PICK_UP =		1 << 4,
	IDLE_CARRY =	1 << 5,
	WALK_CARRY =	1 << 6,
	SELECT_TOOL =	1 << 7,
	GOT_ITEM =		1 << 8,
}

enum ToolState {
	BEGIN,
	DO,
	END
}

state = PS.IDLE;
toolState = ToolState.BEGIN;
dir = DOWN;

k_up = false;
k_down = false;
k_left = false;
k_right = false;
k_action1 = false;
k_action2 = false;
k_action2_pressed = false;
k_action2_released = false;
k_ls_pressed = false;
k_rs_pressed = false;

xVel = 0;
yVel = 0;
zVel = 0;
zGrav = .1;
z = 0;

push_power = 0;
carry_obj = noone;

toolDelay = 0;

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
toolIndex = 1;


create_light(x, y, 40, false, 1.0, self);

anim_idle =			animation_create_directions(spr_player, 0, 1, .0, false, 24, 24);
anim_walk =			animation_create_directions(spr_player, 1, 4, .15, true, 24, 24);
anim_attack =		animation_create_directions(spr_player, 5, 4, .3, false, 24, 24);
anim_use_tool =		animation_create_directions(spr_player, 9, 4, .25, false, 24, 24);
anim_pick_up =		animation_create_directions(spr_player, 13, 2, .05, false, 24, 24);
anim_idle_carry =	animation_create_directions(spr_player, 15, 1, .05, false, 24, 24);
anim_walk_carry =	animation_create_directions(spr_player, 16, 4, .15, true, 24, 24);
anim_select_tool =	animation_create_directions(spr_player, 20, 1, 0, false, 24, 24);
anim_got_item =		animation_create_directions(spr_player, 21, 1, 0, false, 24, 24);

anim = anim_idle;