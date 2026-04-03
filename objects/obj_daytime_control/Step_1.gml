var _step = keyboard_check(vk_shift) ? 20 : 1;
if (keyboard_check(ord("2"))) {
	dayTime = (dayTime + _step) mod maxDayTime;
}
if (keyboard_check(ord("1"))) {
	dayTime = (dayTime - _step + maxDayTime) mod maxDayTime;
}
