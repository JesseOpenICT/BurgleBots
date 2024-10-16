shader_type spatial;

uniform sampler2D image:repeat_enable;

void fragment() {
		vec2 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xz *.5;
		ALBEDO.rgb = texture(image, world_pos).rgb;
}
