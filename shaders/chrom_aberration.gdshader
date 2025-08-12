shader_type canvas_item;

uniform float shift = 0.0015;

void fragment() {
    vec2 uv = SCREEN_UV;
    float r = texture(SCREEN_TEXTURE, uv + vec2(shift, 0.0)).r;
    float g = texture(SCREEN_TEXTURE, uv).g;
    float b = texture(SCREEN_TEXTURE, uv - vec2(shift, 0.0)).b;
    COLOR = vec4(r, g, b, 1.0);
}