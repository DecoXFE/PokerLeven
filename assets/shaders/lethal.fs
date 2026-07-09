#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif


// Standard Balatro/Steamodded externs

extern PRECISION float time;
extern PRECISION number dissolve;
extern PRECISION vec4 texture_details; // (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height)
extern PRECISION vec2 image_details;   // (atlas width, atlas height)
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;


// Has to be used to prevent crashes
extern PRECISION vec2 lethal;

// Hover externs
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;


// Tuning


// Hoverstrength higher = more movement
#define HOVER_MOTION_SCALE 500.0

// strenght of the effect (opacity)
#define EFFECT_OPACITY 0.92

// Transparent black layer between the card art and the lethal effect
#define BLACK_UNDERLAY_OPACITY 0.45

// Godot: if alpha >= 0.99 -> black
#define BLACK_CUTOFF 0.98

// Noise-Contrast
#define NOISE_LOW 0.15
#define NOISE_HIGH 0.82


// Required

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);


// Helpers

float saturate(float x)
{
    return clamp(x, 0.0, 1.0);
}

float hash_f(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise_f(vec2 p)
{
    vec2 i = floor(p);
    vec2 f = fract(p);

    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = hash_f(i + vec2(0.0, 0.0));
    float b = hash_f(i + vec2(1.0, 0.0));
    float c = hash_f(i + vec2(0.0, 1.0));
    float d = hash_f(i + vec2(1.0, 1.0));

    float x1 = mix(a, b, u.x);
    float x2 = mix(c, d, u.x);

    return mix(x1, x2, u.y);
}

float fbm(vec2 p)
{
    float v = 0.0;
    float a = 0.5;

    mat2 m = mat2(
        1.6,  1.2,
       -1.2,  1.6
    );

    for (int i = 0; i < 5; i++)
    {
        v += a * noise_f(p);
        p = m * p;
        a *= 0.5;
    }

    return saturate(v);
}


// Gradient_alpha1 / Gradient_alpha2 Ersatz

// resembles godot .tres Gradients:
//
// offsets:
// 0, 0.265356, 0.511056, 0.759214, 1
//
// values:
// 0.400698, 0.127116, 0.165656, 0.12549, 0.641934

float grad_lerp(float x, float a, float b, float va, float vb)
{
    float t = saturate((x - a) / (b - a));

    // Godot interpolation_mode = 2 as smoothstep
    t = t * t * (3.0 - 2.0 * t);

    return mix(va, vb, t);
}

float gradient_curve(float x)
{
    x = saturate(x);

    if (x < 0.265356) {
        return grad_lerp(x, 0.0, 0.265356, 0.400698, 0.127116);
    }
    else if (x < 0.511056) {
        return grad_lerp(x, 0.265356, 0.511056, 0.127116, 0.165656);
    }
    else if (x < 0.759214) {
        return grad_lerp(x, 0.511056, 0.759214, 0.165656, 0.125490);
    }

    return grad_lerp(x, 0.759214, 1.0, 0.125490, 0.641934);
}

// Gradient_alpha1:
// fill_to = Vector2(0, 1), also vertikal
float gradient_alpha1(vec2 uv)
{
    return gradient_curve(uv.y);
}

// Gradient_alpha2:
// Godot Default, horizontal
float gradient_alpha2(vec2 uv)
{
    return gradient_curve(uv.x);
}


// Noise_texture / Noise_texture2 Replacement


// Rebuild of the Noise-Textur procedurally 

float noise_texture_like(vec2 uv, vec2 seed)
{
    vec2 p = uv;

    vec2 warp;
    warp.x = fbm(p * 2.0 + seed + vec2(1.7, -2.4));
    warp.y = fbm(p * 2.2 - seed + vec2(-3.1, 2.6));
    warp = warp - 0.5;

    float n1 = fbm(p * 3.0 + warp * 2.4 + seed);
    float n2 = fbm(p * 6.2 - warp * 1.8 + seed.yx);
    float n3 = fbm(p * 12.0 + seed * 0.7);

    float n = n1 * 0.56 + n2 * 0.32 + n3 * 0.12;

    return smoothstep(NOISE_LOW, NOISE_HIGH, n);
}


// TIME-Replcement

// Replace Godot TIME with Hover + Mouseposition

float hover_driver()
{
    float h = clamp(hovering, 0.0, 1.0);

    // screen_scale absichern
    float sc = max(screen_scale, 0.001);

    vec2 m = mouse_screen_pos / sc;

    // Mouseposition as pseudotimer
    // Noise moving when hovering
    float d = m.x * 0.018 + m.y * 0.013;

    // including lethal minimal , so that Uniform wont be deleted for  optimization
    d += lethal.x * 0.0001 + lethal.y * 0.00013;

    return d * HOVER_MOTION_SCALE * h;
}


// Godot Alpha-Formel

float godot_alpha(vec2 uv, float driver)
{
    // Godot:
    // TIME * 0.02000
    float n_out10p0 = driver * 0.02000;


    // vec2(-0.30000, -0.21500) * n_out10p0 + UV
    vec2 n_out7p0 = vec2(n_out10p0) * vec2(-0.30000, -0.21500) + uv;


    // texture(Noise_texture, n_out7p0)
    float n_out13p0 = noise_texture_like(n_out7p0, vec2(12.7, -5.4));


    // TIME * -0.03000
    float n_out16p0 = driver * -0.03000;


    // vec2(-0.30000, -0.21500) * n_out16p0 + UV
    vec2 n_out15p0 = vec2(n_out16p0) * vec2(-0.30000, -0.21500) + uv;


    // texture(Noise_texture2, n_out15p0)
    float n_out17p0 = noise_texture_like(n_out15p0, vec2(-8.1, 9.6));


    // n_out18p0 = n_out13p0.x * n_out17p0.x
    float n_out18p0 = n_out13p0 * n_out17p0;


    // n_out26p0 = n_out18p0 * 0.395
    float n_out26p0 = n_out18p0 * 0.39500;


    // n_out19p0 = texture(Gradient_alpha1, UV)
    float n_out19p0 = gradient_alpha1(uv);


    // n_out20p0 = texture(Gradient_alpha2, UV)
    float n_out20p0 = gradient_alpha2(uv);


    // n_out21p0 = n_out19p0.x + n_out20p0.x
    float n_out21p0 = n_out19p0 + n_out20p0;


    // n_out24p0 = n_out18p0 * n_out21p0
    float n_out24p0 = n_out18p0 * n_out21p0;


    // n_out27p0 = n_out24p0 * 1.3
    float n_out27p0 = n_out24p0 * 1.30000;


    // n_out25p0 = n_out26p0 + n_out27p0
    float n_out25p0 = n_out26p0 + n_out27p0;


    // n_out8p0 = 3.13 * n_out25p0
    float n_out8p0 = 3.13000 * n_out25p0;

    return n_out8p0;
}


// Main effect

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 base = Texel(texture, texture_coords);

    // Sprite-local UV using atlas info
    vec2 uv = (((texture_coords) * image_details) - texture_details.xy * texture_details.ba) / texture_details.ba;

    // including lethal minimal , so that Uniform wont be deleted for  optimization
    uv += lethal * 0.000001;

    // TIME-Ersatz
    float driver = hover_driver();

    // Godot Alpha
    float alpha = godot_alpha(uv, driver);

    // Godot:
    // if alpha >= 0.99 -> black
    // else -> red
    float blackMask = step(BLACK_CUTOFF, alpha);

    vec3 godotRed   = vec3(1.0, 0.0, 0.1);
    vec3 godotBlack = vec3(0.0, 0.0, 0.0);

    vec3 shaderCol = mix(godotRed, godotBlack, blackMask);


    float overlayStrength = saturate(alpha) * EFFECT_OPACITY;

    overlayStrength = max(overlayStrength, blackMask);

    vec3 underlayRGB = mix(base.rgb, vec3(0.0), saturate(BLACK_UNDERLAY_OPACITY));
    vec3 finalRGB = mix(underlayRGB, shaderCol, overlayStrength);

    vec4 tex = vec4(finalRGB, base.a);

    return dissolve_mask(tex * colour, texture_coords, uv);
}


// Dissolve / Burn logic

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

    vec2 field_part1 = uv_scaled_centered + 50. * vec2(
        sin(-t / 143.6340),
        cos(-t / 99.4324)
    );

    vec2 field_part2 = uv_scaled_centered + 50. * vec2(
        cos(t / 53.1532),
        cos(t / 61.4532)
    );

    vec2 field_part3 = uv_scaled_centered + 50. * vec2(
        sin(-t / 87.53218),
        sin(-t / 49.0000)
    );

    float field = (1. + (
        cos(length(field_part1) / 19.483) +
        sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92)
    )) / 2.;

    vec2 borders = vec2(0.2, 0.8);

    float res =
        (.5 + .5 * cos((adjusted_dissolve) / 82.612 + (field + -.5) * 3.14))
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


// Hover transform

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.) {
        return transform_projection * vertex_position;
    }

    float mid_dist = length(vertex_position.xy - 0.5 * love_ScreenSize.xy) / length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;

    float scale =
        0.2 *
        (-0.03 - 0.3 * max(0., 0.3 - mid_dist)) *
        hovering *
        (length(mouse_offset) * length(mouse_offset)) /
        (2. - mid_dist);

    return transform_projection * vertex_position + vec4(0, 0, 0, scale);
}
#endif
