extends Node3D

@onready var player: CharacterBody3D = $'../Player'
@onready var camera: Camera3D = $'./Camera3D'

func _process(delta: float) -> void:
	position = player.position
