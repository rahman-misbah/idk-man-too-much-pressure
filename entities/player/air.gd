extends State


func update(_delta: float) -> void:
	if entity.is_on_floor():
		transition_requested.emit("Ground")
