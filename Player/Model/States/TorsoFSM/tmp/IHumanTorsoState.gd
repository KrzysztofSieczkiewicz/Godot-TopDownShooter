class_name IHumanTorsoState extends Resource

signal transition(new_state_name: StringName)

@export var transition_rules: Dictionary[ITorsoTransitionRule, StringName]

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IPlayerTorsoState) -> void:
	pass

func exit() -> void:
	pass

func update(input: PlayerInput, delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
