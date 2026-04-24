extends State


@export var wall_jump_timer_time : float = 0.5
@export var gravity_dampening_factor : float
@export var wall_coyote_time : float = 0.2

@onready var coyote_timer : = $CoyoteTimer
@onready var wall_jump_timer = $WallJumpTimer

var is_in_coyote_time : bool = false 

func _ready() -> void:
	wall_jump_timer.wait_time = wall_jump_timer_time
	coyote_timer.wait_time = wall_coyote_time

func physics_update(delta: float) -> void:
	if not (entity.ray_cast_left.is_colliding() or entity.ray_cast_right.is_colliding()):
		if entity.is_on_floor():
			transition_requested.emit("Ground")
		elif not entity.is_on_floor() and not is_in_coyote_time:
			transition_requested.emit("Air")
	print("wall")
	if entity.velocity.y > 0:
		entity.velocity.y += entity.gravity * gravity_dampening_factor * delta
	else:
		entity.velocity.y += entity.gravity * delta
		
	if Input.is_action_just_pressed("jump") and entity.can_jump:
		print("    JUMP ")
		entity.velocity.y = entity.jump_velocity
		wall_jump_timer.start()
		entity.can_jump = false


func enter() -> void:
	print("EnteredWall")
	entity.can_jump = true


func exit() -> void:
	coyote_timer.start()

func get_wall_direction():
	if entity.is_on_wall():
		return -1 if entity.get_wall_normal().x > 0 else 1 # -1 = left wall, 1 = right wall
	return 0

func _on_wall_jump_timer_timeout() -> void:
	if entity.state_machine.current_state == self:
		entity.can_jump = true


func _on_coyote_timer_timeout() -> void:
	is_in_coyote_time = false
