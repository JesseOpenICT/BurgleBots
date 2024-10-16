shader_type canvas_item;

uniform float scale = 0.03;
uniform bool angle = true;
uniform float loadprogress = 0;
uniform sampler2D bubbles:repeat_enable;

uniform sampler2D logos:repeat_enable;

void fragment() {
	vec2 screenpos = SCREEN_UV/SCREEN_PIXEL_SIZE * SCREEN_PIXEL_SIZE.y /(scale);
	float diagonalramp;
	if (angle){
	diagonalramp = 1.-UV.x + 1.-UV.y;
	}
	else{
	diagonalramp = UV.x + UV.y;
	}
	float bubbletexture = texture(bubbles, screenpos).r;
	COLOR.rgb = vec3(0);
	COLOR.rgb += texture(logos, screenpos/vec2(30.,20.)).rgb;
	COLOR.rgb = vec3(COLOR.r * 0.2 + COLOR.g *0.3 + COLOR.b * 0.15) * 0.5;
	float alpha = diagonalramp*10.-loadprogress*21. + 1.;
	if (alpha > bubbletexture) {
		discard;
	}
	
}
