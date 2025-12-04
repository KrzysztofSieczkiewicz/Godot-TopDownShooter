class_name PlayerLocomotionStateMachine extends Node

@export var STATES: Dictionary[HumanStates.LOCOMOTION_STATE, IHumanLocomotionState]
@export var INITIAL_STATE: HumanStates.LOCOMOTION_STATE

var CURRENT_STATE_KEY: HumanStates.LOCOMOTION_STATE
var CURRENT_STATE: IHumanLocomotionState

var _states: Dictionary = {}

func init(stateManager: PlayerStateManager, parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	for key in STATES:
		var state_resource = STATES[key]
		var state_instance = state_resource.duplicate()
		
		state_instance.stateManager = stateManager
		state_instance.parent = parent
		state_instance.animations = animations
		state_instance.transition.connect(on_state_transition)

		_states[key] = state_instance
	
	CURRENT_STATE_KEY = INITIAL_STATE
	CURRENT_STATE = _states[CURRENT_STATE_KEY]
	CURRENT_STATE.enter(null)

func update(input: PlayerInput, delta: float) -> void:
	CURRENT_STATE.update(input, delta)
	Global.debug_panel.add_property("Current locomotion state", CURRENT_STATE_KEY, 3)

func force_state(new_state_key: HumanStates.LOCOMOTION_STATE) -> void:
	on_state_transition(new_state_key)
	
func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)


func on_state_transition(new_state_key: HumanStates.LOCOMOTION_STATE) -> void:
	var new_state = _states.get(new_state_key)
	
	if new_state != CURRENT_STATE:
		CURRENT_STATE.exit()
		new_state.enter(CURRENT_STATE)
		CURRENT_STATE = new_state
		CURRENT_STATE_KEY = new_state_key
