draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 1);

var _spr = tileset_get_sprite();

var _t = sprite_get_width(_spr) / T;
var _tsx = ((tile) % _t) * T;
var _tsy = ((tile) div _t) * T;

var _w = sprite_get_width(mask_index);
var _h = sprite_get_height(mask_index);

draw_sprite_part(_spr, -1, _tsx, _tsy, _w, _h, floor(x - .5 * _w), floor(y - .5 * _h));
