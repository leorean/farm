function create_harvestable(_x, _y, _harvestableType, _tile) {
	var _obj = instance_create_depth(_x, _y, L_FG, obj_harvestable);
	_obj.tile = _tile;
	_obj.type = _harvestableType;
	
	switch(_harvestableType) {
		case HarvestableType.BUSH_SMALL:
		_obj.mask_index = msk_16x16;
		break;
	}	
}