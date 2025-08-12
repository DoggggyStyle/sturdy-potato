shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform sampler2D lut_tex;
uniform float lut_size = 32.0;

vec3 sample_lut(vec3 color){
    float ls = lut_size;
    color = clamp(color, vec3(0.0), vec3(1.0));
    float b = color.b * (ls - 1.0);
    float bf = fract(b);
    float bi = floor(b);
    float tile_w = ls * ls;
    float x0 = (color.r * (ls - 1.0) + bi * ls) / tile_w;
    float x1 = (color.r * (ls - 1.0) + (bi + 1.0) * ls) / tile_w;
    float y = (color.g * (ls - 1.0)) / (ls - 1.0);
    vec3 c0 = texture(lut_tex, vec2(x0, y)).rgb;
    vec3 c1 = texture(lut_tex, vec2(x1, y)).rgb;
    return mix(c0, c1, bf);
}

void fragment(){
    vec3 col = texture(SCREEN_TEXTURE, UV).rgb;
    col = sample_lut(col);
    COLOR = vec4(col, 1.0);
}
