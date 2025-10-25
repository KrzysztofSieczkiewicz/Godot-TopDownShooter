class_name IPlayerLocomotionState extends Node

signal transition(new_state_name: StringName)

var animations: AnimationPlayer
var parent: CharacterBody3D

func enter(previous_state: IPlayerLocomotionState) -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
