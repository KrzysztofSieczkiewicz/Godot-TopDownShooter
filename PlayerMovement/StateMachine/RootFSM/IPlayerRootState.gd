class_name IPlayerRootState extends Node

signal transition(new_state_name: StringName)

@export var locomotion_constraint: ILocomotionConstraint
@export var torso_constraint: ITorsoConstraint

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IPlayerRootState) -> void:
	pass

func exit() -> void:
	pass

func update(input: PlayerInput, delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
