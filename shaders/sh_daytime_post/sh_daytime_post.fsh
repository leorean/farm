varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_palette;
uniform sampler2D u_light_map;
uniform vec3 u_tint;
uniform float u_darken;
uniform vec2 u_palette_size;
// Sprite sub-rect on texture page (from sprite_get_uvs): left, top, right, bottom in 0–1 space
uniform vec4 u_palette_uv;
uniform float u_palette_strength;

// Rec. 709 luma — match palette by luminance first, RGB only refines hue among similar brightness
const vec3 LUMA = vec3(0.2126, 0.7152, 0.0722);

// Rough saturation 0–1 (max–min)/max; near-black reads as 0
float satMeasure(vec3 c) {
    float mx = max(c.r, max(c.g, c.b));
    if (mx < 1e-4) {
        return 0.0;
    }
    float mn = min(c.r, min(c.g, c.b));
    return (mx - mn) / mx;
}

void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    vec3 lm = texture2D(u_light_map, v_vTexcoord).rgb;
    float light = clamp(max(max(lm.r, lm.g), lm.b), 0.0, 1.0);

    vec3 tintMix = mix(u_tint, vec3(1.0), light);
    vec3 rgb = col.rgb * tintMix;

    float Ys = dot(rgb, LUMA);
    float satSrc = satMeasure(rgb);
    float peakSrc = max(rgb.r, max(rgb.g, rgb.b));
    // Darker pixels: gradually prefer less saturated swatches (avoids neon primaries on muted shadows)
    float darkDesat = 1.0 - smoothstep(0.06, 0.48, Ys);
    const float kDesat = 32.0;
    // Penalize swatches that raise max(R,G,B): luma can match dark maroon vs vivid red; peak catches that
    const float kPeakLift = 48.0;

    // Luminance-primary (search only); output is still the chosen swatch RGB
    const float kLuma = 48.0;
    const float kRgb = 1.0;

    float best = 1.0e20;
    vec3 bestRgb = rgb;
    for (int py = 0; py < 5; py++) {
        for (int px = 0; px < 16; px++) {
            vec2 cell = (vec2(float(px), float(py)) + 0.5) / u_palette_size;
            vec2 puv = vec2(
                mix(u_palette_uv.x, u_palette_uv.z, cell.x),
                mix(u_palette_uv.y, u_palette_uv.w, cell.y));
            vec3 p = texture2D(u_palette, puv).rgb;
            float Yp = dot(p, LUMA);
            vec3 d = rgb - p;
            float dy = Ys - Yp;
            float dist = kLuma * dy * dy + kRgb * dot(d, d);
            float peakP = max(p.r, max(p.g, p.b));
            float lift = max(0.0, peakP - peakSrc);
            dist += kPeakLift * lift * lift;
            // Strong extra cost when swatch luma is above source (0.2 was too weak vs similar-Y vivid hues)
            if (Yp > Ys) {
                float up = Yp - Ys;
                dist += kLuma * 2.75 * up * up;
            }
            float satP = satMeasure(p);
            float excessSat = max(0.0, satP - satSrc);
            dist += kDesat * darkDesat * excessSat * excessSat;
            if (dist < best) {
                best = dist;
                bestRgb = p;
            }
        }
    }

    float ps = u_palette_strength;
    rgb = mix(rgb, bestRgb, ps);

    float effDark = u_darken * (1.0 - light);
    rgb *= (1.0 - effDark);
    rgb = clamp(rgb, 0.0, 1.0);

    gl_FragColor = vec4(rgb, col.a);
}
