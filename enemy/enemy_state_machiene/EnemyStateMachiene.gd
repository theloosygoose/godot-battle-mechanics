@tool
## Root for Enemy Battle Creation
class_name EnemyStateMachine
extends Node

@export var scenes: Array[PackedScene]:
	set(p_scenes):
		if p_scenes !=  scenes:
			scenes = p_scenes 
			update_configuration_warnings()

@export var description: String = "":
	set(p_description):
		if p_description != description:
			description = p_description
			update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if scenes.is_empty():
		warnings.append("Please add one Battle Scene to 'scenes'")
	
	else:
		for battle_scene in scenes:
			if battle_scene.get_state().get_class() != "EnemyBattleState":
				warnings.append(battle_scene.get_state().get_class() + "is not an `EnemyBattleState`")
	

	if description.length() >= 100:
		warnings.append("`description` should be less than 100 characters long.")

	# Returning an empty array means "no warning".
	return warnings
