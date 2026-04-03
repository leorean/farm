varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_palette;
uniform vec3 u_tint;
uniform float u_darken;
uniform vec2 u_palette_size;
uniform float u_palette_strength;

void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    vec3 rgb = col.rgb * u_tint;
    rgb *= (1.0 - u_darken);
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

    vec3 outRgb = mix(rgb, bestRgb, u_palette_strength);
    gl_FragColor = vec4(outRgb, 1.0);
}
