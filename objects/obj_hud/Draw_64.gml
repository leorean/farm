draw_set_colour(c_white);
draw_set_font(global.font_10x10_hud);

draw_sprite_part(spr_hud, -1, 0, 64, 256, 16, 0, 0);

// tool display
var _toolType = obj_player.tools[obj_player.toolIndex].type;
var _toolLevel = obj_player.tools[obj_player.toolIndex].level;
draw_sprite_part(spr_hud, -1, _toolType * 16, _toolLevel * 16, 16, 16, 0, 0);

// daytime
draw_set_halign(fa_right);
draw_set_valign(fa_top);
var _daytime = daytime_to_string(obj_daytime_control.dayTime);
draw_text(V_WIDTH, 0, _daytime);