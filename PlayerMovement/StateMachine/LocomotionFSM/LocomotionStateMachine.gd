class_name PlayerLocomotionStateMachine extends Node

@export var STATES: Dictionary[HumanStates.LOCOMOTION_STATE, IHumanLocomotionState]
@export var INITIAL_STATE: IPlayerLocomotionState
var CURRENT_STATE: IPlayerLocomotionState

var _states: Dictionary = {}

func init(stateManager: PlayerStateManager, parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	for child in get_children():
		if child is IPlayerLocomotionState:
			_states[child.name] = child
			child.stateManager = stateManager
			child.parent = parent
			child.animations = animations
			child.transition.connect(on_state_transition)
		else:
			push_warning("Player Locomotion State Machine contains incompatibile child node")
	
	CURRENT_STATE = INITIAL_STATE
	CURRENT_STATE.enter(null)

func update(input: PlayerInput, delta: float) -> void:
	CURRENT_STATE.update(input, delta)
	Global.debug_panel.add_property("Current locomotion state", CURRENT_STATE.name, 3)

func force_state(new_state: String) -> void:
	on_state_transition(new_state)
	
func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)


func on_state_transition(new_state_name: StringName) -> void:
	var new_state = _states.get(new_state_name)
	
	if new_state == null:
		push_warning("State '" + new_state_name + "' does not exist")
		return
	
	if new_state != CURRENT_STATE:
		CURRENT_STATE.exit()
		new_state.enter(CURRENT_STATE)
		CURRENT_STATE = new_state
