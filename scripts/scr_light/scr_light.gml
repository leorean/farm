function create_light(_x, _y, _radius, _isStatic, _alpha, _parent = noone) {	
	var _l = instance_create_depth(_x, _y, 0, obj_light);
	_l.parent = _parent;
	_l.isStatic = _isStatic;
	_l.radius = _radius;
	_l.radiusOrig = _radius;
	_l.alpha = _alpha;	
	
	return _l;
}