var _frame = floor(min(f_cur, f_max));

draw_sprite_part(spr_effects, -1, _frame * 32, type * 32, 32, 32, x - 16, y - 16);