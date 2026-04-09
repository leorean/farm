function create_harvestable(_x, _y, _hType, _tile) {
	var _obj = instance_create_depth(_x, _y, L_FG, obj_harvestable);
	_obj.tile = _tile;
	_obj.type = _hType;	
	switch(_hType) {
		case HType.GRASS:
			_obj.mask_index = msk_8x8;
			break;
		case HType.BUSH_SMALL:
		case HType.ROCK_SMALL:
		case HType.WOOD_SMALL:
			_obj.mask_index = msk_16x16;
		break;
		case HType.BUSH_BIG:
		case HType.WOOD_BIG:
		case HType.ROCK_BIG:
			_obj.mask_index = msk_32x32;
		break;
	}
}