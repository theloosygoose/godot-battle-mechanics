class_name ActionStateMachiene
extends Node

@export var initial_action: ActionState

var current_action: ActionState
var actions: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():

		if child is ActionState:
			var child_is: ActionState = child 
			actions[child_is.name.to_lower()] = child_is
			child_is.Transitioned.connect(on_child_transition)
			
	if initial_action:
		initial_action.Enter()

		current_action = initial_action


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_action:
		current_action.Update(delta)
		

func _physics_process(delta: float) -> void:
	if current_action:
		current_action.Physics_Update(delta)
		
func on_child_transition(action: ActionState, new_action_name: String) -> void:
	if action != current_action:
		return
	
	var new_action: ActionState 
	
	match actions.has(new_action_name.to_lower()):
		true:
			new_action = actions.get(new_action_name.to_lower())
		false:
			push_error("Could Not Find Action " + new_action_name + " As Child of Action State Machiene")
			return
		
	if current_action:
		current_action.Exit()
	
	new_action.Enter()

	current_action = new_action
		
	
	

