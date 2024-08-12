shader_type spatial;
render_mode cull_disabled, unshaded, shadows_disabled;

uniform vec3 color = vec3(0.3,1,10);

void vertex() {
	//VERTEX.x += sin(TIME * 5.0 + VERTEX.z)*0.1;
	//VERTEX.y += sin(TIME * 5.0 + VERTEX.x * 10.0)*0.01;
}

void fragment() {
//	ALBEDO.x = UV.x;
	ALBEDO = color;
	//ALBEDO.r = UV.y;
	ALPHA = clamp((-16.0*pow((UV.y-0.25), 2)+1.0), 0.1, 1.0);
}
