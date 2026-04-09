switch(type) {
	case ET.BUSH_SMALL_DESTROY:
	case ET.ROCK_SMALL_DESTROY:
	case ET.WOOD_SMALL_DESTROY:
	case ET.STARS_GROUND:
	case ET.STARS:
		f_speed = .3;
	break;
	case ET.GRASS_DESTROY:
		f_speed = .4;
	break;
}

f_cur = min(f_cur + f_speed, f_max + 1);

if (f_cur == f_max + 1) instance_destroy();