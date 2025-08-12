shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.0, 1.0, 0.82, 1.0);
uniform float thickness = 1.5;

void fragment() {
    vec2 texel = SCREEN_PIXEL_SIZE * thickness;
    float alpha = 0.0;
    alpha += texture(TEXTURE, UV + vec2(texel.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(-texel.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, texel.y)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, -texel.y)).a;
    vec4 col = texture(TEXTURE, UV);
    if (col.a < 0.1 && alpha > 0.0) {
        COLOR = outline_color;
    } else {
        COLOR = col;
    }
}