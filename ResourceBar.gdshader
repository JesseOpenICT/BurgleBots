shader_type spatial;
render_mode cull_disabled, unshaded, depth_test_disabled;

uniform vec3 color1;
uniform vec3 color1glow;
uniform vec3 color2;
uniform vec3 color2glow;

uniform float value;
uniform sampler2D image;

void fragment() {
	vec4 img = texture(image, UV);
	if (img.a !=1.) {
		discard;
	}
	if (img.r<value*1.005){
		ALBEDO = color1;
		ALBEDO += color1glow * img.g;
	}
	else{
		ALBEDO = color2;
		ALBEDO += color2glow * img.g;
	}
	
	//ALBEDO.rgb = vec3(texture(image, UV).r);
}
