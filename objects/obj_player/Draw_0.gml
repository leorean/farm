//draw_self();

draw_sprite(spr_shadow, -1, x, bbox_bottom);

var _a = animation_for_direction(anim, dir);
animation_draw(_a, dir == RIGHT ? -1 : 1, 1);