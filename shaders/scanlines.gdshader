shader_type canvas_item;

uniform float intensity = 0.12;
uniform float frequency = 800.0;

void fragment() {
    vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
    float s = sin(SCREEN_UV.y * frequency) * 0.5 + 0.5;
    col.rgb *= (1.0 - intensity * s);
    COLOR = col;
}