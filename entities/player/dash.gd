extends State

@export var dash_speed : float = 600.0
@export var dash_duration : float = 0.15
@export var dash_cooldown : float = 0.5

@onready var cooldown_timer : = $DashCooldownTimer

var dash_timer : float = 0.0
var dash_direction : float = 1.0
var can_dash : bool = true

func physics_update(delta: float) -> void:
	dash_timer -= delta
	print("dash")
	print(dash_direction)
	# Freeze gravity, pure horizontal movement
	entity.velocity.x = dash_direction * dash_speed
	entity.velocity.y = 0.0

	if dash_timer <= 0.0:
		_end_dash()

func enter() -> void:
	dash_direction = 1.0 if !entity.facing_direction else entity.facing_direction
	dash_timer = dash_duration
	can_dash = false
	cooldown_timer.start(dash_cooldown)

	entity.velocity.x = dash_direction * dash_speed
	entity.velocity.y = 0.0

func exit() -> void:
	# Preserve horizontal momentum when leaving dash
	entity.velocity.x = dash_direction * dash_speed * 0.5

func _end_dash() -> void:
	if entity.is_on_floor():
		transition_requested.emit("Ground")
	else:
		transition_requested.emit("Air")

func _on_cooldown_timer_timeout() -> void:
	can_dash = true
