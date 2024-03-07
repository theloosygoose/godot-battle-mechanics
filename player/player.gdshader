shader_type canvas_item;

uniform bool is_dash = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	if (is_dash){
		COLOR.rgb = vec3(1.0);
	}

}

