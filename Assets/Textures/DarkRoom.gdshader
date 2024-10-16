shader_type spatial;

uniform float scale = 0.04;
uniform float loadprogress = .5;
uniform sampler2D bubbles:repeat_enable;

void fragment() {
	ALBEDO = vec3(0,0,0);
	
	vec2 screenpos = SCREEN_UV* (VIEWPORT_SIZE) *(scale);
	float diagonalramp;
	float bubbletexture = texture(bubbles, screenpos).r;
	if (loadprogress < bubbletexture) {
		discard;
	}
}
