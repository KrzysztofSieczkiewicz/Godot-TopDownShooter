class_name HumanStateMachine
extends Node

@export var CURRENT_STATE: IState

var states: Dictionary = {};

# Initializes state machine by setting parent to all states and sets initial state
func init(parent: CharacterBody3D, animations: AnimatedSprite3D) -> void:
	for child in get_children():
		if child is IState:
			states[child.name] = child
			child.transition.connect(on_state_transition)
		else:
			push_warning("State machine contains incompatibile child node")

	CURRENT_STATE.enter()

func _process(delta: float) -> void:
	CURRENT_STATE.update(delta)

func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)

# Calls exit state on current state, sets new state and calls enter on new state
func on_state_transition(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	
	if new_state == null:
		push_warning("State '" + new_state_name + "' does not exist")
	
	if new_state != CURRENT_STATE:
		CURRENT_STATE.exit()
		new_state.enter()
		CURRENT_STATE = new_state
