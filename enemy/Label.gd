extends Label

func _on_health_component_current_health(health:float) -> void:
	text = str(health)