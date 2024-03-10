class_name Projectile
extends Node2D 

var speed: float
var direction: Vector2 = Vector2.ZERO 
var initial_position: Vector2
var imported_texture: Texture2D

var damage: float = 1.0

func _ready() -> void:
	assign_texture()
	
	position = initial_position

func _physics_process(delta: float) -> void:
	position += (speed * direction) * delta


func assign_texture() -> void:		
	if !imported_texture:

		imported_texture = load("res://projectiles/assets/white_pill.png")
		push_error("Texture Not Found Loading Default Texture")

	var sprite2D: Sprite2D
	for child in get_children():
		if child is Sprite2D:
			sprite2D = child
			sprite2D.texture = imported_texture

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var target: HitboxComponent = area
		var attack: Attack = Attack.new()

		attack.attack_damage = damage 
		target.recieve_attack(attack)
		destory()
		
		

func destory() -> void:
	queue_free()