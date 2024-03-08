class_name PlayerDash 
extends Node


@export_group("Dash Parameters")
@export var initial_pause_frames: int = 0
@export var dash_frames: int = 5
@export var dash_speed: float = 500.0
@export var control_back_frame: int = 2

var dash_frames_max: int
		

var is_dashing: bool = false
var dash_frame_counter: int = 0
var final_fixed_frame: bool = false

signal dash_movement(dash_speed: float, delta:float, final_fixed_frame:bool)
signal dash_end

func _ready() -> void:
	dash_frames_max = dash_frames + initial_pause_frames

func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("secondary_action"):
		dash_start()

	if dash_frame_counter > dash_frames_max:
		dash_stop()
		
	if dash_frame_counter == dash_frames_max - control_back_frame:
		final_fixed_frame = true
		
	if is_dashing:
		if dash_frame_counter < initial_pause_frames:
			dash_movement.emit(1, delta, final_fixed_frame)
		else:
			dash_movement.emit(dash_speed, delta, final_fixed_frame)

		dash_frame_counter += 1
		
	

func dash_start() -> void: 
	is_dashing = true

func dash_stop() -> void:
	dash_frame_counter = 0
	is_dashing = false
	final_fixed_frame= false
	dash_end.emit()
