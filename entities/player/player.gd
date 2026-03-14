extends CharacterBody2D

@export var speed : float = 120.0
@export var jump_velocity : float = -350.0
@export_range(0.1, 10, 0.05) var gravity_scale : float = 1

func _physics_process(delta: float) -> void:
	# Add the gravity
	# v = u - (n)gt, where
	#   n = gravity scaling factor
	#	g = - gravity
	#	t = delta
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
