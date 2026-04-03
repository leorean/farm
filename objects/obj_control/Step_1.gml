if (keyboard_check_pressed(vk_escape)) {
	game_end();
}

//if (keyboard_check_pressed(ord("Q"))) {
//	game_restart();
//}

if (keyboard_check_pressed(ord("R"))) {
	room_restart();
}

if (keyboard_check_pressed(ord("T"))) {
	game_restart();
}

if (keyboard_check_pressed(vk_f1)) {
	global.debug = !global.debug;
}


/*if (keyboard_check(vk_space)) {
	game_set_speed(10, gamespeed_fps);
} else {
	game_set_speed(60, gamespeed_fps);
}*/