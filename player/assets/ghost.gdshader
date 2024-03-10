shader_type canvas_item;

uniform float value = 1.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.rgb = vec3(1.0);
	COLOR.a = COLOR.a * value;
}
