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

var _xo = 0;
var _yo = 4;
cx = x + _xo;
cy = y + _yo;

target_tile_x = ((x + _xo) div TT) * TT + sign(dir) * (dir == LEFT || dir == RIGHT) * TT;
target_tile_y = ((y + _yo) div TT) * TT + sign(dir) * (dir == UP || dir == DOWN) * TT;
var _xt = target_tile_x;
var _yt = target_tile_y;
var _toolType = tools[toolIndex].type;
var _toolLevel = tools[toolIndex].level;

toolDelay = max(toolDelay - 1, 0);

if (has_flag(state, PS.IDLE | PS.WALK)) {
	
	if (state == PS.WALK) toolDelay = 0;

	if (k_ls_pressed) toolIndex = (toolIndex + array_length(tools) - 1) % array_length(tools);
	if (k_rs_pressed) toolIndex = (toolIndex + 1) % array_length(tools);
	
	switch(_toolType) {
		case Tool.HOE:
		case Tool.WATERING_CAN:
		case Tool.PICKAXE:
		case Tool.AXE:
			if (k_action2) {
				state = PS.USE_TOOL;
				anim = animation_set_array(anim_use_tool);
				toolDelay = 16;
				toolState = ToolState.BEGIN;
			}
		break;
		case Tool.SEED_BAG:
		case Tool.SCYTHE:
		case Tool.SWORD:
			if (k_action2_pressed) {
				state = PS.ATTACK;
				toolDelay = 16;
				anim = animation_set_array(anim_attack);
				toolState = ToolState.BEGIN;
			}
		break;
	}
}

if (has_flag(state, PS.USE_TOOL)) {
	xVel = 0;
	yVel = 0;
	var _a = animation_for_direction(anim, dir);
	
	if (toolState == ToolState.BEGIN) {
		_a.f_cur = 0;
		toolBounced = false;
		if (toolDelay == 0 && !k_action2) {
			toolState = ToolState.DO;
		}		
	}
	
	if (toolState == ToolState.DO) {
		if (animation_is_done(_a)) {
			toolDelay = 20;
			toolState = ToolState.END;
			
			
			if (_toolType == Tool.HOE) {
				if (check_if_can_till(_xt, _yt)) {
					till_soil(_xt, _yt);
				}
			}
			
			if (_toolType == Tool.WATERING_CAN) {
				if (check_if_can_water(_xt, _yt)) {
					water_tilled_soil(_xt, _yt);
				}
			}
	
			if (_toolType == Tool.PICKAXE || _toolType == Tool.AXE) {
				var _dx = (dir == LEFT || dir == RIGHT) ? cx + sign(dir) * 16 : cx;
				var _dy = (dir == UP || dir == DOWN) ? cy + sign(dir) * 16 : cy;
				var _h = instance_place(_dx, _dy, obj_harvestable);
				
				if (instance_exists(_h) && _h.state == HState.IDLE) {
					
					if (_toolType == Tool.PICKAXE) {
						if (has_flag(_h.type, HType.ROCK_SMALL | HType.ROCK_BIG)) {
							if (_toolLevel >= _h.minToolLevel) {
								_h.hitDamage = player_get_damage_for_tool(_toolType, _toolLevel);
							} else {
								toolBounced = true;
							}
						}
					}
					if (_toolType == Tool.AXE) {
						if (has_flag(_h.type, HType.WOOD_SMALL | HType.WOOD_BIG)) {
							if (_toolLevel >= _h.minToolLevel) {
								_h.hitDamage = player_get_damage_for_tool(_toolType, _toolLevel);
							} else {
								toolBounced = true;
							}
						}
					}
				}
				
				if(check_if_can_untill(_xt, _yt)) {
					untill_soil(_xt, _yt);
				}
			}
		}
	}
	
	if (toolState == ToolState.END) {
		if (toolBounced) {
			state = PS.TOOL_BOUNCE;
			anim = animation_set_array(anim_tool_bounce);
			toolDelay = 30;			
		} else {
			if (toolDelay == 0) {		
				state = PS.IDLE;
				anim = animation_set_array(anim_idle);
			}
		}
	}
}

if (has_flag(state, PS.ATTACK)) {
	xVel = 0;
	yVel = 0;
	var _a = animation_for_direction(anim, dir);
	
	if (toolState == ToolState.BEGIN) {
		toolState = ToolState.DO;
		toolBounced = false;
		
		if (_toolType == Tool.SCYTHE) {
			var _harvestables = player_get_harvestables_for_scythe(cx, cy, dir);
			for (var _i = 0; _i < array_length(_harvestables); _i++) {
				var _h = _harvestables[_i];
				if (has_flag(_h.type, HType.BUSH_SMALL | HType.GRASS | HType.BUSH_BIG)) {
					if (_toolLevel >= _h.minToolLevel) {
						_h.hitDamage = player_get_damage_for_tool(_toolType, _toolLevel);
					} else {
						// no bouncing with scythe or sword
					}
				}
			}
		}
			
		if (_toolType == Tool.SWORD) {
			var _harvestables = player_get_harvestables_for_sword(cx, cy, dir);

			for (var _i = 0; _i < array_length(_harvestables); _i++) {
				var _h = _harvestables[_i];
				if (has_flag(_h.type, HType.BUSH_SMALL | HType.GRASS | HType.BUSH_BIG)) {
					if (_toolLevel >= _h.minToolLevel) {
						_h.hitDamage = player_get_damage_for_tool(_toolType, _toolLevel);
					} else {
						// no bouncing with scythe or sword
					}
				}
			}
		}
	}
	
	if (toolState == ToolState.DO) {
		if (animation_is_done(_a)) {
			toolState = ToolState.END;
			toolDelay = 0; // no delay			
		}
	}
	
	if (toolState == ToolState.END) {
		if (toolBounced) {
			state = PS.TOOL_BOUNCE;
			anim = animation_set_array(anim_tool_bounce);
			toolDelay = 60;
		} else {
			if (toolDelay == 0) {
				state = PS.IDLE;
				anim = animation_set_array(anim_idle);
			}
		}
	}
}

if (state == PS.TOOL_BOUNCE) {
	xVel = 0;
	yVel = 0;
	if (toolDelay == 0) {
		state = PS.IDLE;
		anim = animation_set_array(anim_idle);
	}
}

// collision & movement

if (!player_check_collision(self, xVel, 0)) {
	x += xVel;
} else {
	xVel = 0;
}

if (!player_check_collision(self, 0, yVel)) {
	y += yVel;
} else {
	yVel = 0;
}

// end step
animation_update(self, animation_for_direction(anim, dir));