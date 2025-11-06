class_name ILocomotionConstraint extends Node

func get_max_speed(base_speed: float) -> float:
	push_error("Must implement get_max_speed()")
	return base_speed
	
func filter_movement_input(input: Vector2) -> Vector2:
	push_error("Must implement filter_movement_input()")
	return input
