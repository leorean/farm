//draw_self();
var _a = animation_for_direction(anim, dir);
animation_draw(_a, dir == RIGHT ? -1 : 1, 1);

draw_rectangle(target_tile_x, target_tile_y, target_tile_x + TT, target_tile_y + 16, 1);