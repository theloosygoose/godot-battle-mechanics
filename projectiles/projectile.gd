class_name Projectile
extends Area2D 


var damage:int = 10
var proj_health: int = 100

var speed: float
var direction: Vector2 = Vector2.ZERO 
var initial_position: Vector2

var imported_texture: Texture2D

func _ready() -> void:
	assign_texture()
	
	position = initial_position

func _physics_process(delta: float) -> void:
	position += (speed * direction) * delta

func _process(_delta: float) -> void:
	check_health()

func take_damage(damage_taken: int) -> void:
	proj_health -= damage_taken

func check_health() -> void:
	if proj_health <= 0:
		queue_free()

func assign_texture() -> void:		
	if !imported_texture:

		imported_texture = load("res://projectiles/assets/white_pill.png")
		push_error("Texture Not Found Loading Default Texture")

	var sprite2D: Sprite2D
	for child in get_children():
		if child is Sprite2D:
			sprite2D = child
			sprite2D.texture = imported_texture