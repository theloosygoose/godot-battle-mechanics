extends Sprite2D

var opacity: float = 1.0
var timer: Timer


@onready var shader_material: ShaderMaterial = material

func _ready() -> void:
	timer = get_children()[0]

func _process(_delta: float) -> void:
	opacity = (timer.time_left) - 0.005
	shader_material.set_shader_parameter("value", opacity)
		

func _on_timer_timeout() -> void:
	queue_free()
