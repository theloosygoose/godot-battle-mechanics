class_name Shoot
extends Node2D 


## Projectile Scene [br]
## If no scene is loaded will load default projectile scene
@export var projectile_scene: PackedScene 
var default_projectile_scene: PackedScene = preload("res://projectiles/projectile.tscn")


## Speed for projectile
@export var projectile_speed: float
## Scale for projectile
@export var projectile_scale: Vector2 
## Damage for projectile
@export var projectile_damage: float


var projectile_scene_checked: PackedScene 

## Cooldown of shooter should be Timer Node
@export var cooldown_timer: Timer 
var can_shoot: bool = true

func _ready() -> void:
	projectile_scene_checked = check_projectile_scene()
	cooldown_timer.timeout.connect(_on_timer_timeout)

	
func _process(_delta: float) -> void:
	if can_shoot:
		if input_shoot():
			cooldown_timer.start()
			var projectile: Projectile = projectile_scene_checked.instantiate()
			projectile.speed = projectile_speed
			projectile.direction = Vector2.UP
			projectile.initial_position = global_position
			projectile.damage = projectile_damage

			get_parent().get_parent().add_child(projectile)	
			can_shoot = false


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
	if Input.is_action_pressed("main_action"):
		return true

	return false
	
func _on_timer_timeout() -> void:
	can_shoot = true
