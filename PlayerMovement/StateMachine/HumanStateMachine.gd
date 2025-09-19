class_name HumanStateMachine
extends Node

@export var CURRENT_STATE: IMovementState

@onready var player: CharacterBody3D = $".."

var _states: Dictionary = {}

# Allows for manual state machine setup with parent and animations injection - TODO: consider for later
func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	for child in get_children():
		if child is IMovementState:
			_states[child.name] = child
			child.parent = player
			child.animations = animations
			child.transition.connect(on_state_transition)
		else:
			push_warning("State machine contains incompatibile child node")
	
	CURRENT_STATE.enter()

#
#func _ready() -> void:
	#for child in get_children():
		#if child is IState:
			#_states[child.name] = child
			#child.parent = player
			#child.transition.connect(on_state_transition)
		#else:
			#push_warning("State machine contains incompatibile child node")
	#
	#CURRENT_STATE.enter()


func _process(delta: float) -> void:
	CURRENT_STATE.update(delta)
	Global.debug_panel.add_property("Current State", CURRENT_STATE.name, 1)


func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)


func on_state_transition(new_state_name: StringName) -> void:
	var new_state = _states.get(new_state_name)
	
	if new_state == null:
		push_warning("State '" + new_state_name + "' does not exist")
		return
	
	if new_state != CURRENT_STATE:
		CURRENT_STATE.exit()
		new_state.enter()
		CURRENT_STATE = new_state
