extends State


func physics_update(delta: float) -> void:
	if not entity.is_on_wall():
		if entity.is_on_floor():
			transition_requested.emit("Ground")
		elif not entity.is_on_floor():
			transition_requested.emit("Air")
	
func enter() -> void:
	entity.can_jump = true
