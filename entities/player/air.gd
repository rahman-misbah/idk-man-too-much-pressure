extends State
	

func physics_update(delta: float) -> void:
	if entity.is_on_floor():
		transition_requested.emit("Ground")
	if entity.ray_cast_left.is_colliding() or entity.ray_cast_right.is_colliding():
	#if entity.is_on_wall():
		transition_requested.emit("Wall")
	print("......")
	
	if Input.is_action_just_pressed("dash") and entity.can_dash:
		transition_requested.emit("Dash")
	
	# Add the gravity
	# v = u - (n)gt, where
	#   n = gravity scaling factor
	#	g = - gravity
	#	t = delta
	entity.velocity.y += entity.gravity * delta


func enter() -> void:
	# entity.can_jump = false
	pass
