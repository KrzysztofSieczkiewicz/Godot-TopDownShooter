class_name PlayerLocomotionStateMachine extends Node

@export var CURRENT_STATE: IPlayerLocomotionState

var _states: Dictionary = {}

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	for child in get_children():
		if child is IPlayerLocomotionState:
			_states[child.name] = child
			child.parent = parent
			child.animations = animations
			child.transition.connect(on_state_transition)
		else:
			push_warning("Player Locomotion State Machine contains incompatibile child node")
	
	CURRENT_STATE.enter(null)


func _process(delta: float) -> void:
	CURRENT_STATE.update(delta)
	Global.debug_panel.add_property("Current locomotion state", CURRENT_STATE.name, 3)


func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)


# TODO: consider a solution that doesn't utilize the stringNames, but types
# TODO: add crouching stance state and prevent player from sprinting in this state
func on_state_transition(new_state_name: StringName) -> void:
	var new_state = _states.get(new_state_name)
	
	if new_state == null:
		push_warning("State '" + new_state_name + "' does not exist")
		return
	
	if new_state != CURRENT_STATE:
		CURRENT_STATE.exit()
		new_state.enter(CURRENT_STATE)
		CURRENT_STATE = new_state
