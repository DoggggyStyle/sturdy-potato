shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float vignette_strength : hint_range(0.0,1.0) = 0.22;
uniform float bloom_mix : hint_range(0.0,1.0) = 0.15;
uniform float chroma : hint_range(0.0,2.0) = 0.12;
uniform vec3 grade_lift = vec3(0.02, 0.0, 0.02);
uniform vec3 grade_gamma = vec3(1.02, 1.0, 1.02);
uniform vec3 grade_gain = vec3(1.08, 1.02, 1.12);

void fragment(){
    vec2 uv = UV;
    vec4 col = texture(SCREEN_TEXTURE, uv);

    // subtle chromatic aberration
    vec2 off = (uv - 0.5) * chroma * 0.002;
    float r = texture(SCREEN_TEXTURE, uv + off).r;
    float g = col.g;
    float b = texture(SCREEN_TEXTURE, uv - off).b;
    vec3 c = vec3(r,g,b);

    // grade
    c = (c + grade_lift);
    c = pow(c, grade_gamma);
    c = c * grade_gain;

    // vignette
    float d = distance(uv, vec2(0.5));
    float vig = smoothstep(0.6, 0.95, d);
    c *= mix(1.0, 1.0 - vignette_strength, vig);

    COLOR = vec4(c,1.0);
}
