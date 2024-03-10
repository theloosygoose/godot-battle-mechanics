class_name HealthComponent
extends Node

@export var MAX_HEALTH: float = 100.0

var health: float 

#Send the current health for those who want to check it 
signal current_health(health: float)

func _ready() -> void:
	health = MAX_HEALTH

	current_health.emit(health)

func take_damage(damage_taken:float) -> void:
	health = health - damage_taken
	current_health.emit(health)

	if health <= 0:
		get_parent().queue_free()

		