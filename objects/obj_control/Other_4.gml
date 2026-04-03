
if (global.gameState == GameState.MENU) {
	room_width = 512;
	room_height = 192;
	
}

if (global.gameState == GameState.LEVEL) {
	instance_create_depth(0, 0, 0, obj_level_control);
}