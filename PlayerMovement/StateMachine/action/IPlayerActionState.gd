class_name IPlayerActionState extends Node

signal transition(new_state_name: StringName)

var animations: AnimationPlayer
var parent: CharacterBody3D

func can_transition_to_locomotion(next_state: Script) -> bool:
	return false;

func enter(previous_state: IPlayerActionState) -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
