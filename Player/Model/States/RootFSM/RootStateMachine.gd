class_name PlayerRootStateMachine extends Node

@export var STATES: Array[HumanRootStateLink]
@export var INITIAL_STATE: HumanStates.ROOT_STATE

var CURRENT_STATE_KEY: HumanStates.ROOT_STATE
var CURRENT_STATE: IHumanRootState

var _states: Dictionary[HumanStates.ROOT_STATE, IHumanRootState] = {}


func init(stateManager: PlayerStateManager, parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	for state in STATES:
		var state_resource = state.value
		var state_instance = state_resource.duplicate()
			
		state_instance.stateManager = stateManager
		state_instance.parent = parent
		state_instance.animations = animations
		state_instance.transition.connect(on_state_transition)
		
		_states[state.key] = state_instance
	
	CURRENT_STATE_KEY = INITIAL_STATE
	CURRENT_STATE = _states[CURRENT_STATE_KEY]
	CURRENT_STATE.enter(null)


func update(input: PlayerInput, delta: float) -> void:
	CURRENT_STATE.update(input, delta)
	Global.debug_panel.add_property("Current root state", CURRENT_STATE_KEY, 1)


func force_state(new_state: HumanStates.ROOT_STATE) -> void:
	on_state_transition(new_state)


func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)


func on_state_transition(new_state_key: HumanStates.ROOT_STATE) -> void:
	var new_state = _states.get(new_state_key)
	
	if new_state != CURRENT_STATE:
		CURRENT_STATE.exit()
		new_state.enter(CURRENT_STATE)
		CURRENT_STATE = new_state
		CURRENT_STATE_KEY = new_state_key
