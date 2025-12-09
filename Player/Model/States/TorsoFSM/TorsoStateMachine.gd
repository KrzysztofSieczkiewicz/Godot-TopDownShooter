class_name PlayerTorsoStateMachine extends Node

@export var STATES: Array[HumanTorsoStateLink]
#@export var INITIAL_STATE: HumanStates.LOCOMOTION_STATE

@export var INITIAL_STATE: IPlayerTorsoState
var CURRENT_STATE: IPlayerTorsoState

var _states: Dictionary = {}


func init(stateManager: PlayerStateManager, parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	for child in get_children():
		if child is IPlayerTorsoState:
			_states[child.name] = child
			child.stateManager = stateManager
			child.parent = parent
			child.animations = animations
			child.transition.connect(on_state_transition)
		else:
			push_warning("Player Action State Machine contains incompatibile child node")
	
	CURRENT_STATE = INITIAL_STATE
	CURRENT_STATE.enter(null)


func update(input: PlayerInput, delta: float) -> void:
	CURRENT_STATE.update(input, delta)
	Global.debug_panel.add_property("Current action state", CURRENT_STATE.name, 2)


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
