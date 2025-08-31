class_name IState
extends Node

signal transition(new_state_name: StringName)

var animations: AnimatedSprite3D
var parent: CharacterBody3D

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
