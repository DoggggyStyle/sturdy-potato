shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float strength : hint_range(0.0, 1.0) = 0.12;
uniform float time_scale : hint_range(0.0, 10.0) = 1.0;

float hash(vec2 p){ return fract(sin(dot(p, vec2(12.9898,78.233))) * 43758.5453); }

void fragment(){
    vec2 uv = UV;
    vec3 col = texture(SCREEN_TEXTURE, uv).rgb;
    float n = hash(uv * (TIME * time_scale + 123.456));
    col = mix(col, col + (n - 0.5) * strength, strength);
    COLOR = vec4(col, 1.0);
}
