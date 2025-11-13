class_name ILocomotionState extends Resource

signal transition(new_state_name: StringName)

@export var transition_rules: Dictionary[ILocomotionTransitionRule, StringName]

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IPlayerLocomotionState) -> void:
	pass

func exit() -> void:
	pass

func update(input: PlayerInput, delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
