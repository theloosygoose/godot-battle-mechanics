class_name MovementCharacteristics
extends Node 

@export_group("Movement Characteristics")
@export_range(0,10) var accelleration_val: float = 2
@export_range(0,10) var deceleration_val: float = 10
@export_range(10, 1000) var max_speed: float = 1120.0



var accelleration: float = 0:
	get:
		return accelleration_val / 100
		
var deceleration: float = 0:
	get:
		return deceleration_val / 100