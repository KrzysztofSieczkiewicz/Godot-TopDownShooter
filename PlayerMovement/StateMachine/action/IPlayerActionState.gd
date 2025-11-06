class_name IPlayerActionState extends Node

signal transition(new_state_name: StringName)

@export var locomotion_constraint: ILocomotionConstraint

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IPlayerActionState) -> void:
	pass

func exit() -> void:
	pass

func update(input: PlayerInput, delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
