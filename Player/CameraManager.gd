extends Node3D

@onready var _player: CharacterBody3D = $'../Player'

func _process(delta: float) -> void:
	position = _player.position
