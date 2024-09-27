shader_type spatial;
render_mode cull_disabled;

uniform vec4 red = vec4(239, 49, 37, 0);
uniform vec4 orange = vec4(245, 127, 40, 1);
uniform vec4 yellow = vec4(255, 240, 0, 2);
uniform vec4 green = vec4(88, 185, 70, 3);
uniform vec4 blue = vec4(0, 84, 165, 4);
uniform vec4 purple = vec4(159, 36, 143,5);

uniform float widthheightproportion = 1.5;

uniform vec4 black = vec4(0,0,0,1.5);
uniform vec4 brown = vec4(96, 58, 22, 2.25);
uniform vec4 cyan = vec4(124, 191, 233, 3);
uniform vec4 pink = vec4(244, 152, 191, 3.75);
uniform vec4 white = vec4(255, 255, 255, 4.5);

vec3 getcolor(float uv, vec4 color, vec3 base) {
    if (uv > color.a/6.) {
        return color.rgb / 255.;
    }
    else {
        return base;
    }
}

void fragment() {
    ALBEDO = getcolor(UV.y, red, ALBEDO.rgb);
    ALBEDO = getcolor(UV.y, orange, ALBEDO.rgb);
    ALBEDO = getcolor(UV.y, yellow, ALBEDO.rgb);
    ALBEDO = getcolor(UV.y, green, ALBEDO.rgb);
    ALBEDO = getcolor(UV.y, blue, ALBEDO.rgb);
    ALBEDO = getcolor(UV.y, purple, ALBEDO.rgb);
    
    float triangle = 1.-(abs(0.5-UV.y) + (UV.x*widthheightproportion));
    
    ALBEDO = getcolor(triangle, black, ALBEDO.rgb);
    ALBEDO = getcolor(triangle, brown, ALBEDO.rgb);
    ALBEDO = getcolor(triangle, cyan, ALBEDO.rgb);
    ALBEDO = getcolor(triangle, pink, ALBEDO.rgb);
    ALBEDO = getcolor(triangle, white, ALBEDO.rgb);
    
    METALLIC = 1.;
    ROUGHNESS = 1.0;
}