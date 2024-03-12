class_name EnemyBattleState
extends Node2D

signal Transitioned

enum StateType {
	ATTACK,
	SPECIAL_ABILITY,
	IDLE,
	DEATH,
	ENTERANCE	
}

@export var state_type: StateType
## Machine that EnemyBattleState is child of
@onready var machine: EnemyStateMachine = get_parent()

func physics_update(_delta: float) -> void:
	pass

func update(_delta: float) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass