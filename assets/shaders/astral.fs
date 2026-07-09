#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

// =========================
// Balatro / Steamodded externs
// =========================
extern PRECISION float time;
extern PRECISION number dissolve;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// Deine Edition sendet jetzt "astral".
// Wird minimal benutzt, damit das Uniform nicht wegoptimiert wird.
extern PRECISION vec2 astral;

// Standard Hover externs
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

// =========================
// Tuning
// =========================

// Transparenter blauer Overlay-Anteil
#define BLUE_OVERLAY_STRENGTH 0.44

// Extra Leuchten beim Hover
#define BLUE_HOVER_BOOST 0.12

// Allgemeine Sternhelligkeit
#define STAR_BRIGHTNESS 1.48

// Automatische langsame Sternbewegung
#define STAR_DRIFT_SPEED 0.010

// Wie beim alten Shader: sehr hoher Hover-Motion-Scale
#define HOVER_MOTION_SCALE 7500.0

// Pixel -> UV Umrechnung.
// Wenn Hover zu schwach: 0.000006
// Wenn Hover zu stark: 0.000002
#define HOVER_PIXEL_FACTOR 0.000006

// Maximale UV-Verschiebung
#define HOVER_UV_LIMIT 0.11

// Richtung umdrehen, falls es falsch herum wirkt
#define HOVER_DIRECTION 1.0

// Drei Ebenen-Multiplikatoren
#define FAR_LAYER_HOVER     0.18
#define MID_LAYER_HOVER     0.65
#define NEAR_LAYER_HOVER    1.45

// =========================
// Forward declaration
// =========================
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

// =========================
// Helpers
// =========================

float saturate(float x)
{
    return clamp(x, 0.0, 1.0);
}

float hash12(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec2 hash22(vec2 p)
{
    vec2 q = vec2(
        dot(p, vec2(127.1, 311.7)),
        dot(p, vec2(269.5, 183.3))
    );

    return fract(sin(q) * 43758.5453);
}

float noise_f(vec2 p)
{
    vec2 i = floor(p);
    vec2 f = fract(p);

    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = hash12(i + vec2(0.0, 0.0));
    float b = hash12(i + vec2(1.0, 0.0));
    float c = hash12(i + vec2(0.0, 1.0));
    float d = hash12(i + vec2(1.0, 1.0));

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

float fbm(vec2 p)
{
    float v = 0.0;
    float a = 0.5;

    mat2 m = mat2(
        1.6,  1.2,
       -1.2,  1.6
    );

    for (int i = 0; i < 4; i++)
    {
        v += a * noise_f(p);
        p = m * p;
        a *= 0.5;
    }

    return saturate(v);
}

// =========================
// Star rendering
// =========================

vec3 render_star_layer(
    vec2 uv,
    vec2 hover_shift,
    float scale,
    float density,
    float base_size,
    float brightness,
    float seed
) {
    vec2 drift = vec2(
        time * STAR_DRIFT_SPEED,
        -time * STAR_DRIFT_SPEED * 0.73
    );

    // Hover wird vor dem Scale angewendet.
    // Dadurch ist die Bewegung wirklich sichtbar.
    vec2 p = (uv + hover_shift + drift) * scale;
    p += vec2(seed, seed * 1.371);

    vec2 base_cell = floor(p);
    vec2 local = fract(p);

    vec3 result = vec3(0.0);

    // 3x3 Nachbarzellen, damit Sterne nicht abgeschnitten werden.
    for (int xo = -1; xo <= 1; xo++)
    {
        for (int yo = -1; yo <= 1; yo++)
        {
            vec2 offset = vec2(float(xo), float(yo));
            vec2 cell = base_cell + offset;

            float rnd = hash12(cell + seed);

            // Niedriger density-Wert = mehr Sterne
            float exists = step(density, rnd);

            vec2 star_pos = offset + hash22(cell + seed * 2.17);

            vec2 delta = local - star_pos;
            float d = length(delta);

            float size_rand = hash12(cell + seed * 4.3);
            float star_size = base_size * mix(0.65, 1.45, size_rand);

            // Kern
            float core = 1.0 - smoothstep(0.0, star_size, d);

            // Weicher Glow
            float glow = 1.0 - smoothstep(star_size, star_size * 3.4, d);

            // Kleine Kreuz-Flares
            float flare_x = 1.0 - smoothstep(0.0, star_size * 0.42, abs(delta.y));
            flare_x *= 1.0 - smoothstep(star_size * 0.25, star_size * 2.9, abs(delta.x));

            float flare_y = 1.0 - smoothstep(0.0, star_size * 0.42, abs(delta.x));
            flare_y *= 1.0 - smoothstep(star_size * 0.25, star_size * 2.9, abs(delta.y));

            float flare = (flare_x + flare_y) * 0.13;

            // Twinkle
            float twinkle = 0.78 + 0.22 * sin(
                time * 1.35 +
                hash12(cell + seed * 9.1) * 6.28318
            );

            float star = exists * twinkle * brightness;

            float shape = core * 1.95 + glow * 0.12 + flare;

            vec3 white      = vec3(1.0, 1.0, 1.0);
            vec3 blue_white = vec3(0.62, 0.82, 1.0);
            vec3 cyan       = vec3(0.42, 0.92, 1.0);

            float color_pick = hash12(cell + seed * 12.7);

            vec3 col = mix(blue_white, white, smoothstep(0.20, 0.82, color_pick));
            col = mix(col, cyan, smoothstep(0.88, 1.0, color_pick) * 0.42);

            result += col * shape * star;
        }
    }

    return result;
}

// =========================
// Main effect
// =========================

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 base = Texel(texture, texture_coords);

    // Sprite-local UV using atlas info
    vec2 uv = (((texture_coords) * image_details) - texture_details.xy * texture_details.ba) / texture_details.ba;

    // astral nur minimal benutzen, damit Steamodded/LÖVE das Uniform behält.
    uv += astral * 0.000001;

    // --------------------------------------------------
    // Hover-Vektor direkt aus Balatro-Hover-Daten
    // --------------------------------------------------

    vec2 mouse_delta = (screen_coords.xy - mouse_screen_pos.xy) / max(screen_scale, 0.001);

    vec2 hover_base = -mouse_delta * HOVER_PIXEL_FACTOR * HOVER_MOTION_SCALE * hovering * HOVER_DIRECTION;

    hover_base = clamp(hover_base, vec2(-HOVER_UV_LIMIT), vec2(HOVER_UV_LIMIT));

    // --------------------------------------------------
    // Aspect-korrigierte Koordinaten
    // --------------------------------------------------

    vec2 p = uv - vec2(0.5);
    p.x *= texture_details.b / texture_details.a;

    vec2 star_uv = p + vec2(0.5);

    // --------------------------------------------------
    // Transparentes blaues Astral-Overlay
    // --------------------------------------------------

    float haze1 = fbm(p * 2.3 + vec2(time * 0.012, -time * 0.009));
    float haze2 = fbm(p * 5.2 + vec2(-time * 0.009, time * 0.006));

    float haze = haze1 * 0.70 + haze2 * 0.30;

    float r = length(p);
    float edge = smoothstep(0.10, 0.78, r);

    vec3 deep_blue   = vec3(0.010, 0.030, 0.105);
    vec3 astral_blue = vec3(0.040, 0.200, 0.760);
    vec3 cyan_blue   = vec3(0.160, 0.580, 1.000);

    vec3 blue_overlay = mix(deep_blue, astral_blue, haze);
    blue_overlay += cyan_blue * haze * 0.11;
    blue_overlay += astral_blue * edge * 0.13;

    // --------------------------------------------------
    // Genau 3 Stern-Ebenen
    // Jede Ebene nutzt denselben Hover, aber anderen Multiplikator
    // --------------------------------------------------

    vec3 stars = vec3(0.0);
    //     render_star_layer(
    //     uv,
    //     hover_shift,
    //     scale,
    //     density,
    //     base_size,
    //     brightness,
    //     seed
    // )

    // Ebene 1: weit hinten, viele kleine Sterne, wenig Bewegung
    stars += render_star_layer(
        star_uv,
        hover_base * FAR_LAYER_HOVER,
        42.0,
        0.956,
        0.125,
        0.48,
        10.0
    );

    // Ebene 2: mittlere Distanz
    stars += render_star_layer(
        star_uv,
        hover_base * MID_LAYER_HOVER,
        25.0,
        0.948,
        0.134,
        0.78,
        41.0
    );

    // Ebene 3: nahe Sterne, größer, stärkste Hover-Bewegung
    stars += render_star_layer(
        star_uv,
        hover_base * NEAR_LAYER_HOVER,
        13.0,
        0.912,
        0.129,
        1.05,
        77.0
    );

    stars *= STAR_BRIGHTNESS;

    // --------------------------------------------------
    // Final mix
    // --------------------------------------------------

    float hover_amount = saturate(length(hover_base) / HOVER_UV_LIMIT);

    float overlay_strength = BLUE_OVERLAY_STRENGTH + hover_amount * BLUE_HOVER_BOOST;

    vec3 finalRGB = mix(base.rgb, blue_overlay, overlay_strength);

    // Sterne über die Karte legen
    finalRGB += stars;

    // Blauer Glow bei hellen Sternen
    float star_intensity = max(stars.r, max(stars.g, stars.b));
    finalRGB += vec3(0.07, 0.23, 1.0) * pow(star_intensity, 1.35) * 0.06;

    vec4 tex = vec4(finalRGB, base.a);

    return dissolve_mask(tex * colour, texture_coords, uv);
}

// =========================
// Dissolve / Burn logic
// =========================

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(
            shadow ? vec3(0.,0.,0.) : tex.xyz,
            shadow ? tex.a * 0.3 : tex.a
        );
    }

    float adjusted_dissolve = (dissolve * dissolve * (3. - 2. * dissolve)) * 1.02 - 0.01;

    float t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv * texture_details.ba))) / max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);

    vec2 field_part1 = uv_scaled_centered + 50. * vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50. * vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50. * vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1. + (
        cos(length(field_part1) / 19.483) +
        sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92)
    )) / 2.;

    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5 * cos((adjusted_dissolve) / 82.612 + (field + -.5) * 3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y) * (5. + 5. * dissolve) : 0.) * dissolve
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y) * (5. + 5. * dissolve) : 0.) * dissolve
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x) * (5. + 5. * dissolve) : 0.) * dissolve
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y) * (5. + 5. * dissolve) : 0.) * dissolve;

    if (
        tex.a > 0.01 &&
        burn_colour_1.a > 0.01 &&
        !shadow &&
        res < adjusted_dissolve + 0.8 * (0.5 - abs(adjusted_dissolve - 0.5)) &&
        res > adjusted_dissolve
    ) {
        if (
            !shadow &&
            res < adjusted_dissolve + 0.5 * (0.5 - abs(adjusted_dissolve - 0.5)) &&
            res > adjusted_dissolve
        ) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(
        shadow ? vec3(0.,0.,0.) : tex.xyz,
        res > adjusted_dissolve ? (shadow ? tex.a * 0.3 : tex.a) : .0
    );
}

// =========================
// Hover transform
// =========================

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.) {
        return transform_projection * vertex_position;
    }

    float mid_dist = length(vertex_position.xy - 0.5 * love_ScreenSize.xy) / length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;

    float scale = 0.2 * (-0.03 - 0.3 * max(0., 0.3 - mid_dist))
                * hovering
                * (length(mouse_offset) * length(mouse_offset))
                / (2. - mid_dist);

    return transform_projection * vertex_position + vec4(0, 0, 0, scale);
}
#endif
