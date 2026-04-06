var _step = keyboard_check(vk_shift) ? 20 : 1;
if (keyboard_check(ord("2"))) {
	dayTime = (dayTime + _step) mod maxDayTime;
	debug(dayTime);
}
if (keyboard_check(ord("1"))) {
	dayTime = (dayTime - _step + maxDayTime) mod maxDayTime;
	debug(dayTime);
}

timeTicks = max(timeTicks - 1, 0);
if (timeTicks == 0) {
	dayTime = (dayTime + 1) % maxDayTime;
	timeTicks = maxTimeTicks;
}