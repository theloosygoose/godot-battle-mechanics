@tool
## Root for Enemy Battle Creation
class_name EnemyStateMachine
extends Node

##Parent whom this enemyscene is for children can also access this varible to interact with the parent easier
@onready var parent: Node2D = get_parent()

## Scenes that are children of EnemyStateMachine
var battle_states: Dictionary:
	set(p_scenes):
		if p_scenes !=  battle_states:
			battle_states = p_scenes 
			notify_property_list_changed()
			update_configuration_warnings()

@export var initial_state: EnemyBattleState

var current_state: EnemyBattleState

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if battle_states.is_empty():
		warnings.append("Please add one Battle Scene as a Child")
	else:
		for node: Node in battle_states:
			if node.name != "EnemyBattleState":
				warnings.append(node.name + "is not an `EnemyBattleState`")
	
	# Returning an empty array means "no warning".
	return warnings
	
func _ready() -> void:
	check_children(false)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		## Check the Children Real Time in the Editor
		check_children(true)
	
	if !Engine.is_editor_hint():
		if current_state:
			current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
	
	
func check_children(in_editor: bool) -> void:
	for child in get_children():
		if child is EnemyBattleState:
			var battle_state_node: EnemyBattleState = child
			battle_states[battle_state_node.name.to_lower()] = battle_state_node
			if !in_editor:
				battle_state_node.Transitioned.connect(on_battle_state_transitioned)

			
func on_battle_state_transitioned(state: EnemyBattleState, new_state_name: String) -> void:
	if state != current_state:
		return

	var new_state: EnemyBattleState = battle_states.get(new_state_name.to_lower())
	
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
