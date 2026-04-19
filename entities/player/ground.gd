extends State


func update(delta: float) -> void:
	if not entity.is_on_floor():
		transition_requested.emit("Air")
