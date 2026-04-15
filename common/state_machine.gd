extends Node
class_name StateMachine

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	# Register all child states
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.entity = get_parent()
			child.transition_requested.connect(_on_transition_requested)

	# Set initial state (first child)
	if states.size() > 0:
		change_state(states.keys()[0])

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(state_name: String) -> void:
	if not states.has(state_name):
		push_warning("State not found: " + state_name)
		return

	if current_state:
		current_state.exit()

	current_state = states[state_name]
	current_state.enter()

func _on_transition_requested(new_state_name: String) -> void:
	change_state(new_state_name)
