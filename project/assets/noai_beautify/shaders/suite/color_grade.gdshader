shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float exposure : hint_range(0.1, 3.0) = 1.0;
uniform float contrast : hint_range(0.5, 2.0) = 1.0;
uniform float saturation : hint_range(0.0, 2.0) = 1.0;
uniform vec3 lift = vec3(0.0, 0.0, 0.0);
uniform vec3 gamma = vec3(1.0, 1.0, 1.0);
uniform vec3 gain = vec3(1.0, 1.0, 1.0);

void fragment(){
    vec2 uv = UV;
    vec3 c = texture(SCREEN_TEXTURE, uv).rgb * exposure;

    // lift/gamma/gain
    c = c + lift;
    c = pow(max(c, vec3(1e-5)), gamma);
    c = c * gain;

    // simple contrast & saturation
    float luma = dot(c, vec3(0.2126, 0.7152, 0.0722));
    c = mix(vec3(luma), c, saturation);
    c = (c - 0.5) * contrast + 0.5;

    COLOR = vec4(c, 1.0);
}
