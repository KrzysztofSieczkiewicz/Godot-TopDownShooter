class_name IHumanLocomotionState extends Resource

signal transition(new_state_name: StringName)

@export var transition_rules: Dictionary[ILocomotionTransitionRule, HumanStates.LOCOMOTION_STATE]

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
