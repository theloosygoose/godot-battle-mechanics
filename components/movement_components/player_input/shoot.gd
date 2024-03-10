class_name Shoot
extends Node2D 


@export_group("Projectile")
@export var projectile_scene: PackedScene 
var default_projectile_scene: PackedScene = preload("res://projectiles/projectile.tscn")

@export_subgroup("Projectile Proporties")
@export var projectile_speed: float
@export var projectile_scale: Vector2 
@export var projectile_texture: Texture2D
@export var projectile_damage: float

var projectile_scene_checked: PackedScene 

func _ready() -> void:
	projectile_scene_checked = check_projectile_scene()

func _process(_delta: float) -> void:
	if input_shoot():
		var projectile: Projectile = projectile_scene_checked.instantiate()
		projectile.imported_texture = projectile_texture
		projectile.speed = projectile_speed
		projectile.direction = Vector2.UP
		projectile.initial_position = global_position
		projectile.damage = projectile_damage

		get_parent().get_parent().add_child(projectile)	


func check_projectile_scene() -> PackedScene:
	if projectile_scene:
		match projectile_scene.get_state().get_node_name(0):
			"Projectile":
				return projectile_scene 
				
			_:
				push_error(str(projectile_scene) + " : is not a Projectile")
				push_error("USING DEFAULT PROJECTILE: " + str(default_projectile_scene))
				return default_projectile_scene

	push_error("NO PROJECTILE SCENE SET")
	push_error("USING DEFAULT PROJECTILE: " + str(default_projectile_scene))
	return default_projectile_scene
			
func input_shoot() -> bool:
	if Input.is_action_just_pressed("main_action"):
		print("shoot")
		return true

	return false