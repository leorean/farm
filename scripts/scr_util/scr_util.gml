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

function daytime_to_string(_daytime) {
    // Clamp input
    var _t = clamp(_daytime, 0, 2400);

    // Convert to total minutes (0–1440)
    var _total_minutes = round((_t / 2400) * 1440);

    // Handle edge case (2400 → 1440 → wrap to 0)
    if (_total_minutes >= 1440) _total_minutes = 0;

    // Extract hours and minutes
    var _hours = _total_minutes div 60;
    var _minutes = _total_minutes mod 60;

    // Determine AM/PM
    var _suffix = (_hours >= 12) ? "PM" : "AM";

    // Convert to 12-hour format
    var _display_hours = _hours mod 12;
    if (_display_hours == 0) _display_hours = 12;

    // Leading zeros for BOTH hours and minutes
    var _hour_str = string_format(_display_hours, 2, 0);
	_hour_str = string_replace(_hour_str, " ", "0");
    var _minute_str = string_format(_minutes, 2, 0);
	_minute_str = string_replace(_minute_str, " ", "0");	

    return _hour_str + ":" + _minute_str + _suffix;
}