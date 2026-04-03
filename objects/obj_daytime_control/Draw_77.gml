if (!surface_exists(application_surface)) {
	exit;
}

var p = daytime_sample();

var _sw = max(1, surface_get_width(application_surface));
var _sh = max(1, surface_get_height(application_surface));

var _buf_w = window_get_width();
var _buf_h = window_get_height();
if (_buf_w < 2 || _buf_h < 2) {
	_buf_w = display_get_width();
	_buf_h = display_get_height();
}
if (_buf_w < 2) _buf_w = _sw * V_ZOOM;
if (_buf_h < 2) _buf_h = _sh * V_ZOOM;

var _fit = min(_buf_w / _sw, _buf_h / _sh);
var _scale = min(V_ZOOM, _fit);
var _draw_w = _sw * _scale;
var _draw_h = _sh * _scale;
var _ox = floor((_buf_w - _draw_w) / 2);
var _oy = floor((_buf_h - _draw_h) / 2);

gpu_set_blendenable(false);
gpu_set_texfilter(false);

shader_set(sh_daytime_post);
shader_set_uniform_f(shader_get_uniform(sh_daytime_post, "u_tint"), p.tr, p.tg, p.tb);
shader_set_uniform_f(shader_get_uniform(sh_daytime_post, "u_darken"), p.d);
shader_set_uniform_f(shader_get_uniform(sh_daytime_post, "u_palette_size"), 16, 5);
var _t = dayTime mod maxDayTime;
var _ps = palette_strength;
if (_t >= dayTint_t0 && _t < dayTint_t1) {
	_ps = 0;
}
shader_set_uniform_f(shader_get_uniform(sh_daytime_post, "u_palette_strength"), _ps);

var _samp = shader_get_sampler_index(sh_daytime_post, "u_palette");
texture_set_stage(_samp, sprite_get_texture(spr_palette, 0));

draw_surface_ext(application_surface, _ox, _oy, _scale, _scale, 0, c_white, 1);

shader_reset();
gpu_set_texfilter(true);
gpu_set_blendenable(true);
