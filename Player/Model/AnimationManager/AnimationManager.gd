extends Node

const ANIM_ANGLES = {
	"front": 0.0,
	"front-right": 45.0,
	"right": 90.0,
	"back-right": 135.0,
	"back": 180.0,
	"back-left": -135.0,
	"left": -90.0,
	"forward-left": -45.0,
	"idle": 0.0
}

func match_animation(velocity: Vector3):
	pass

func _get_matching_animation(velocity: Vector3):
	
