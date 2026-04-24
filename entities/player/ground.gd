extends State


func physics_update(delta: float) -> void:
	if not entity.is_on_floor():
		transition_requested.emit("Air")
	#if entity.ray_cast_left.is_colliding() or entity.ray_cast_right.is_colliding():
	if entity.ray_cast_left.is_colliding() or entity.ray_cast_right.is_colliding():
		transition_requested.emit("Wall")
	
	if Input.is_action_just_pressed("jump") and entity.can_jump:
		print("    JUMP ")
		entity.velocity.y = entity.jump_velocity

func enter() -> void:
	entity.can_jump = true

func exit() -> void:
	entity.can_jump = false
