class_name ILocomotionConstraint extends Node

var filtered_input: PlayerInput
	
func get_max_speed(base_speed: float) -> float:
	push_error("Must implement get_max_speed()")
	return base_speed
	
func filter_player_input(input: PlayerInput):
	push_error("Must implement filter_movement_input()")
	filtered_input = input

func get_filtered_input() -> PlayerInput:
	return filtered_input;
