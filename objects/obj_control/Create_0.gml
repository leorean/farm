window_set_size(V_WIDTH * V_ZOOM, V_HEIGHT * V_ZOOM);
window_center();
//display_set_gui_size(V_WIDTH * V_ZOOM, V_HEIGHT * V_ZOOM);
display_set_gui_size(V_WIDTH, V_HEIGHT);

// GLOBAL ASSETS

global.font_10x10_hud =	font_add_sprite(spr_font_10x10_hud, ord(" "), true, 1);
//global.font_damage =		font_add_sprite(spr_font_damage, ord(" "), true, 0);
//global.font_damage_crit =	font_add_sprite(spr_font_damage_crit, ord(" "), true, 1);
//global.font_10x10 =			font_add_sprite(spr_font_10x10, ord(" "), true, 1);
//global.font_6x6_number =	font_add_sprite(spr_font_6x6_number, ord("/"), true, 1);

// GLOBAL OBJECTS & VARS

instance_create_depth(0, 0, 0, obj_input);
//global.player_stats = stats_player_create();

enum GameState {
	MENU,
	LEVEL,
	PAUSE
}

global.gameState = GameState.LEVEL;