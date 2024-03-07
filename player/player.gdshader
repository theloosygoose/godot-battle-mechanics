shader_type canvas_item;

uniform bool is_dash = false;

void vertex() {
	// Called for every vertex the material is visible on.
	if (is_dash){
		  VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
		
	}
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	if (is_dash){
		COLOR.rgb = vec3(1.0);
		COLOR.a = COLOR.a * cos(TIME);
	}

}

