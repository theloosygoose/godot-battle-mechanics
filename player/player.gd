extends Area2D

var texture: Texture2D 
var texture_scale: Vector2

var shader: ShaderMaterial

func _ready() -> void:
	for child in get_children():
		if child is Sprite2D:
			var sprite_2d_child:Sprite2D = child
			texture_scale = sprite_2d_child.scale
			texture = sprite_2d_child.texture

	shader = material as ShaderMaterial


func _process(_delta: float) -> void:
	is_shooting()
	

func is_shooting() -> bool:
	if Input.is_action_just_pressed("main_action"):
		print_debug("Main Action")
		return true
	else:
		return false


func _on_player_dash_dash_movement(_dash_speed:float, _delta:float, _final_fixed_frame:bool) -> void:
	var ghost_effect:Sprite2D = preload("res://player/assets/ghost.tscn").instantiate()

	shader.set_shader_parameter("is_dash", true)

	ghost_effect.texture = texture
	ghost_effect.position = position
	ghost_effect.scale = texture_scale
	get_parent().add_child(ghost_effect)

func _on_player_dash_dash_end() -> void:
	shader.set_shader_parameter("is_dash", false) 
