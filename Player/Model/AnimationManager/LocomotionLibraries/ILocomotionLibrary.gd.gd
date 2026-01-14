class_name ILocomotionLibrary
extends Resource

enum MovementMode { IDLE, SLOW, MEDIUM, FAST }

@export var move_sets: Dictionary[MovementMode, ILocomotionSet]
