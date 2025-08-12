shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float amount : hint_range(0.0, 2.0) = 0.0;
uniform float scanlines : hint_range(0.0, 1.0) = 0.0;

void fragment(){
    vec2 uv = UV;
    vec2 off = (uv - 0.5) * amount * 0.002;
    float r = texture(SCREEN_TEXTURE, uv + off).r;
    float g = texture(SCREEN_TEXTURE, uv).g;
    float b = texture(SCREEN_TEXTURE, uv - off).b;
    vec3 c = vec3(r,g,b);
    if (scanlines > 0.0){
        float s = sin(uv.y * 1200.0) * 0.5 + 0.5;
        c *= mix(1.0, 1.0 - 0.08, s * scanlines);
    }
    COLOR = vec4(c,1.0);
}
