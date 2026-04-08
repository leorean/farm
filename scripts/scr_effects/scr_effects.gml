function create_effect(_x, _y, _type) {
	var _eff = instance_create_depth(_x, _y, L_EFFECTS, obj_effect);
	_eff.type = _type;
}