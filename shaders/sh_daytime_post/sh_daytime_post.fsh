varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_palette;
uniform sampler2D u_light_map;
uniform vec3 u_tint;
uniform float u_darken;
uniform vec2 u_palette_size;
uniform float u_palette_strength;

void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    vec3 lm = texture2D(u_light_map, v_vTexcoord).rgb;
    float light = clamp(max(max(lm.r, lm.g), lm.b), 0.0, 1.0);

    vec3 tintMix = mix(u_tint, vec3(1.0), light);
    vec3 rgb = col.rgb * tintMix;
    float effDark = u_darken * (1.0 - light);
    rgb *= (1.0 - effDark);
    rgb = clamp(rgb, 0.0, 1.0);

    float best = 1.0e20;
    vec3 bestRgb = rgb;
    for (int py = 0; py < 5; py++) {
        for (int px = 0; px < 16; px++) {
            vec2 puv = (vec2(float(px), float(py)) + 0.5) / u_palette_size;
            vec3 p = texture2D(u_palette, puv).rgb;
            vec3 d = rgb - p;
            float dist = dot(d, d);
            if (dist < best) {
                best = dist;
                bestRgb = p;
            }
        }
    }

    float ps = u_palette_strength * (1.0 - light);
    vec3 outRgb = mix(rgb, bestRgb, ps);
    gl_FragColor = vec4(outRgb, 1.0);
}
