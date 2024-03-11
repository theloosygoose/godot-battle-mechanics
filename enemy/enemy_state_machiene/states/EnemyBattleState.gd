class_name EnemyBattleState
extends Node2D

enum StateType {
	ATTACK,
	SPECIAL_ABILITY,
	IDLE,
	DEATH,
	ENTERANCE
}

@export var state_type: StateType

func physics_update(_delta: float) -> void:
	pass

func update(_delta: float) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass