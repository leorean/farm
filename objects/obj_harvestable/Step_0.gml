if (!init) {
	init = true;
	switch(type) {
		case HType.BUSH_SMALL:
			hp = 1;
		break;
		case HType.GRASS:
			hp = 1;
		break;
		case HType.ROCK_SMALL:
			hp = 3;
		break;
		case HType.WOOD_SMALL:
			hp = 3;
		break;
	}
}

if (hitDamage > 0) {
	hp = max(hp - hitDamage, 0);	
	if (hp > 0) {
		if (type != HType.GRASS) {
			create_effect(x, y, ET.STARS_GROUND);
		}
	} else {
		//create_effect(x, y, ET.STARS);
		state = HState.DESTROY;
	}
	
	hitDamage = 0;
}

if (state == HState.DESTROY) {
	switch(type) {
		case HType.BUSH_SMALL:
			create_effect(x, y, ET.BUSH_SMALL_DESTROY);
		break;
		case HType.GRASS:
			create_effect(x, y, ET.GRASS_DESTROY);
		break;
		case HType.ROCK_SMALL:
			create_effect(x, y, ET.ROCK_SMALL_DESTROY);
		break;
		case HType.WOOD_SMALL:
			create_effect(x, y, ET.WOOD_SMALL_DESTROY);
		break;
	}
	
	instance_destroy();
}