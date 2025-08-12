shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float threshold : hint_range(0.0, 2.0) = 1.0;
uniform float intensity : hint_range(0.0, 2.0) = 0.35;
uniform float blur : hint_range(0.0, 5.0) = 2.0;

void fragment(){
    vec2 uv = UV;
    vec3 col = texture(SCREEN_TEXTURE, uv).rgb;
    float lum = dot(col, vec3(0.2126, 0.7152, 0.0722));
    vec3 hi = max(col - vec3(threshold), vec3(0.0));
    // poor-man blur by sampling 5 taps
    vec2 px = 1.0 / vec2(textureSize(SCREEN_TEXTURE, 0));
    vec3 sum = hi;
    sum += texture(SCREEN_TEXTURE, uv + vec2(px.x, 0.0) * blur).rgb;
    sum += texture(SCREEN_TEXTURE, uv - vec2(px.x, 0.0) * blur).rgb;
    sum += texture(SCREEN_TEXTURE, uv + vec2(0.0, px.y) * blur).rgb;
    sum += texture(SCREEN_TEXTURE, uv - vec2(0.0, px.y) * blur).rgb;
    sum /= 5.0;
    vec3 outc = texture(SCREEN_TEXTURE, uv).rgb + sum * intensity;
    COLOR = vec4(outc, 1.0);
}
