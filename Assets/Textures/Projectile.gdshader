shader_type spatial;
render_mode cull_front, unshaded;

uniform sampler2D noise : repeat_enable;
uniform vec3 color;



float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}



void fragment() {
	float basic_fresnel = fresnel(2.0, NORMAL, VIEW);
	ALBEDO = color+(color+.1)*basic_fresnel;
	float alpha = 1.1-UV.y;
	if (alpha < texture(noise,UV+TIME*.4).r){
		discard;
	}

}
