if (instance_exists(parent)) {
	x = parent.x;
	y = parent.y;
}

if (parent != noone && !instance_exists(parent)) {
	instance_destroy();
}