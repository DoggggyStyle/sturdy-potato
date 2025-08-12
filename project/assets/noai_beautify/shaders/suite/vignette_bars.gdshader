shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float vignette : hint_range(0.0,1.0) = 0.2;
uniform float bars : hint_range(0.0,0.3) = 0.0; // cinematic bars 0..0.3
uniform float softness : hint_range(0.0,1.0) = 0.4;

void fragment(){
    vec2 uv = UV;
    vec3 c = texture(SCREEN_TEXTURE, uv).rgb;

    // bars
    float top = step(bars, uv.y);
    float bot = step(uv.y, 1.0 - bars);
    float mask = top * bot;
    c *= mask;

    // vignette
    float d = distance(uv, vec2(0.5));
    float v = smoothstep(0.6, 1.0, d);
    c *= mix(1.0, 1.0 - vignette, pow(v, 1.0 - softness));

    COLOR = vec4(c, 1.0);
}
