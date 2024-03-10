class_name HitboxComponent
extends Area2D

@export var health_component: HealthComponent

func recieve_attack(attack: Attack) -> void:
	if health_component:
		health_component.take_damage(attack.attack_damage)


func _on_area_entered(_area:Area2D) -> void:
	pass