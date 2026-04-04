application_surface_draw_enable(true);

surf_lights = -1;

// 2400 ticks per day: 100 per hour (4:00 = 400, 7:00 = 700, 16:00 = 1600, 19:00 = 1900)
maxDayTime = 2400;
dayTime = 700; // 7:00 AM

// [dayTint_t0, dayTint_t1): identity tint + no palette blend (original pixels)
dayTint_t0 = 700;
dayTint_t1 = 1600;

// Outside daytime: 0 = no palette snap, 1 = full snap to spr_palette
palette_strength = 0.5;

depth = -900000;
surf = -1;

// Returns struct { tr, tg, tb, d } — tint RGB and darkness amount (0 = none, 1 = black)
daytime_sample = function() {
	var dt = self.dayTime;
	var mt = self.maxDayTime;
	var t = dt mod mt;
	// 700–1600: flat (1,1,1) + d=0 so daytime matches source art (no tint / darken)
	var kt = [0, 400, 700, 1600, 1900, 2100, 2400];
	var kr = [0.18, 0.95, 1, 1, 1.0, 0.55, 0.18];
	var kg = [0.22, 0.5, 1, 1, 0.38, 0.32, 0.22];
	var kb = [0.48, 0.35, 1, 1, 0.28, 0.72, 0.48];
	var kd = [0.52, 0.38, 0, 0, 0.12, 0.42, 0.52];
	var n = array_length(kt);
	for (var i = 0; i < n - 1; i++) {
		if (t >= kt[i] && t < kt[i + 1]) {
			var u = (t - kt[i]) / (kt[i + 1] - kt[i]);
			return {
				tr: clamp(lerp(kr[i], kr[i + 1], u), 0, 1),
				tg: clamp(lerp(kg[i], kg[i + 1], u), 0, 1),
				tb: clamp(lerp(kb[i], kb[i + 1], u), 0, 1),
				d: clamp(lerp(kd[i], kd[i + 1], u), 0, 1)
			};
		}
	}
	return { tr: kr[0], tg: kg[0], tb: kb[0], d: kd[0] };
};
