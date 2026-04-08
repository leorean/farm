if (state == HarvestableState.DESTROY) {
	switch(type) {
		case HarvestableType.BUSH_SMALL:
			create_effect(x, y, ET.BUSH_SMALL_DESTROY);
		break;
		case HarvestableType.GRASS:
			create_effect(x, y, ET.GRASS_DESTROY);
		break;
		case HarvestableType.ROCK_SMALL:
			create_effect(x, y, ET.ROCK_SMALL_DESTROY);
		break;
		case HarvestableType.WOOD_SMALL:
			create_effect(x, y, ET.WOOD_SMALL_DESTROY);
		break;
	}
	
	instance_destroy();
}