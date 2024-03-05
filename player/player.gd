extends Area2D


func _process(_delta: float) -> void:
	is_shooting()
	

func is_shooting() -> bool:
	if Input.is_action_just_pressed("main_action"):
		print_debug("Main Action")
		return true
	else:
		return false
