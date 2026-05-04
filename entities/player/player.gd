extends CharacterBody2D

class_name Player

@export var speed : float = 120.0
@export var jump_velocity : float = -350.0
@export var gravity : int = 980
var can_jump : bool = true
var can_dash : bool = true
var ray_cast_target_position_x : int
var facing_direction : float

@onready var state_machine : = $PlayerStateMachine
@onready var ray_cast_left : = $RayCastLeft
@onready var ray_cast_right : = $RayCastRight
@onready var jump_cooldown_timer : = $JumpCooldownTimer
@onready var grapple_line : Line2D = $GrappleLine
@onready var anchor_detector : Area2D = $GrappleAnchorDetector


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	facing_direction = Input.get_axis("move_left", "move_right")
	if not state_machine.current_state.name == "Dash":
		if facing_direction:
			velocity.x = facing_direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func get_facing_direction() -> float:
	return facing_direction
