class_name ILocomotionConstraint extends Node

# TODO: instead of funtion calls there should be just numerical values like
# - speed_multiplier: int
# - forbidden_actions: Array[string]
# then it should be accepted by locomotion machine next to the input -> update(input, constraint, delta)
# and handled by each state separately (maybe with help of common method filter_constrained_actions(input, constraint) )
# or find a better place to execute this constraints filtering - no point in passing constraints to the locmotion machine for it just to call a single method
# preferably state manager? or maybe make use of LocomotionConstraints node (attach the script and initalize it in the PlayerStateManager constructor)
# then, even when the ActionState will expand into ActionSubstates and the ownership of LocomotionConstraint moves to the substates - 
# it will be clearly retrieveable and explicitly called in the state manager

# or - actually consider - should IPlayerActionState return the filtered input instead - it'd call on it's own filter methods to return the inputs.
# then the state manager can read curernt inputs from the action state and provide them to the legs state

var filtered_input: PlayerInput

func get_max_speed(base_speed: float) -> float:
	push_error("Must implement get_max_speed()")
	return base_speed
	
func filter_player_input(input: PlayerInput):
	push_error("Must implement filter_movement_input()")
	filtered_input = input

func get_filtered_input() -> PlayerInput:
	return filtered_input;
