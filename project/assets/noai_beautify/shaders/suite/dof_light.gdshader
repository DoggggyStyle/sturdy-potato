shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float focus : hint_range(0.0, 1.0) = 0.5;
uniform float strength : hint_range(0.0, 5.0) = 1.2;
uniform float radius : hint_range(0.0, 5.0) = 1.5;

void fragment(){
    vec2 uv = UV;
    vec3 col = texture(SCREEN_TEXTURE, uv).rgb;
    float depth = vec4(1.0).r;
    float coc = abs(depth - focus) * strength;
    vec2 px = 1.0 / vec2(textureSize(SCREEN_TEXTURE, 0));
    vec3 acc = col;
    acc += texture(SCREEN_TEXTURE, uv + vec2(px.x, 0.0) * radius * coc).rgb;
    acc += texture(SCREEN_TEXTURE, uv - vec2(px.x, 0.0) * radius * coc).rgb;
    acc += texture(SCREEN_TEXTURE, uv + vec2(0.0, px.y) * radius * coc).rgb;
    acc += texture(SCREEN_TEXTURE, uv - vec2(0.0, px.y) * radius * coc).rgb;
    acc /= 5.0;
    COLOR = vec4(acc, 1.0);
}