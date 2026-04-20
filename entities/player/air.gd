extends State


func physics_update(delta: float) -> void:
	if entity.is_on_floor():
		transition_requested.emit("Ground")
	if entity.is_on_wall():
		transition_requested.emit("Wall")
