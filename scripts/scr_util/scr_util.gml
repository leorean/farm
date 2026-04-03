function debug() {	
	if (global.debug) {
		var _msg = "";
		for (var _i = 0; _i < argument_count; _i++) {
			_msg += string(argument[_i])
			if (_i < argument_count - 1) _msg += ", ";
		}
		show_debug_message(string(_msg));
	}
}

function has_flag(_value, _flag) {
    return (_value & _flag) != 0;
}

function in(_value, _a, _b) {
	return _value >= _a && _value <= _b;
}

function array_find(_arr, _item) {
	for (_i = 0; _i < array_length(_arr); _i++) {
		if (_arr[_i] == _item) return true;
	}
	return false;
}

