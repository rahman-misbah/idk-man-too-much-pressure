extends Node
class_name State

signal transition_requested(new_state_name: String)

var entity: Node   # reference to the parent (player / enemy / etc.)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
