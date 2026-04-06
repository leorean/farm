draw_set_colour(c_white);
draw_set_font(global.font_10x10_hud);

// tool display
var _tool = obj_player.tools[obj_player.toolIndex];
draw_sprite_part(spr_hud, -1, _tool * 16, 0, 16, 16, 0, V_HEIGHT - 16);

// daytime
draw_set_halign(fa_right);
draw_set_valign(fa_top);
var _daytime = daytime_to_string(obj_daytime_control.dayTime);
draw_text(V_WIDTH, 0, _daytime);