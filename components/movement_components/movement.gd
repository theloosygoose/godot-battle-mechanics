class_name MovementComponent
extends Node

#Check for Dependicies
var parent: Node2D 

func find_movement_characteristics() -> MovementCharacteristics:
	for child in get_children():
		if child is MovementCharacteristics:
			return child as MovementCharacteristics
	return null 


func _get_configuration_warnings() -> PackedStringArray:
	var mvmt_check := find_movement_characteristics()
	parent = self.get_parent() as Node2D 

	if not mvmt_check:
		return ["This node must have a MovementCharacteristics as a child"]
		
	if not parent:
		return ["This node must have a parent that is Node2D"]
		
	return []


#Movement Data and Calculations
var external_movement:bool = false

var prev_data:Array = [Vector2.ZERO, 0.0]

var accelleration:float = 0.0
var deceleration:float = 0.0
var max_speed:float = 0.0

func _ready() -> void:
	var characteristics:= find_movement_characteristics()

	if characteristics:

		accelleration = characteristics.accelleration
		deceleration = characteristics.deceleration
		max_speed = characteristics.max_speed

		
	parent = self.get_parent() as Node2D
	
		
func _physics_process(delta: float) -> void:

	if !external_movement:
		var velocity:Vector2 = calculate_movement()

		parent.position += velocity * delta


#Movement Functions
func calculate_movement() -> Vector2:

	var new_velocity: Vector2 = Vector2.ZERO

	new_velocity = get_direction()
	
	new_velocity = current_frame_velocity_handler(new_velocity)
	new_velocity = check_max_speed(new_velocity)

	new_velocity = handle_snap_stop(new_velocity)
	
	prev_data = next_frame_velocity_data(new_velocity)

	return new_velocity	

func get_direction() -> Vector2:
	var direction:Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	return direction.normalized()
	
func current_frame_velocity_handler(direction_vector: Vector2) -> Vector2:

	var calculated_velocity: Vector2 = (direction_vector * (max_speed) + prev_data[0])
	
	if prev_data[1] >= calculated_velocity.length():
		calculated_velocity -= prev_data[0] * deceleration 
	elif prev_data[1] < calculated_velocity.length():
		calculated_velocity += prev_data[0] * accelleration 
	
	return calculated_velocity


func handle_snap_stop(new_velocity: Vector2) -> Vector2:
	if new_velocity.length() <= max_speed / 10:
		return Vector2.ZERO
	else:
		return new_velocity
		
func next_frame_velocity_data(new_velocity: Vector2)	-> Array:
	var velocity_with_friction: Vector2 =  new_velocity 
	var prev_speed: float = new_velocity.length()
	
	return [velocity_with_friction, prev_speed]

func check_max_speed(velocity: Vector2) -> Vector2:
	if velocity.length() > max_speed:
		return velocity.normalized() * max_speed
	else:
		return velocity

func _on_player_dash_dash_movement(dash_speed:float, delta:float, lastframe:bool) -> void:
	external_movement = true

	var prev_direction:Vector2 = prev_data[0]
	
	parent.position += (prev_direction.normalized() * dash_speed) * delta
	
	if lastframe:
		prev_data[0] = prev_direction.normalized() * dash_speed / 3
		external_movement = false

