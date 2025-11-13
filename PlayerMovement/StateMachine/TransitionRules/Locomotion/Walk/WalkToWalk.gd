class_name WalkToWalkTransitionRule extends ILocomotionTransitionRule

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_walk = input.locomotion_actions.has("walk")
	
	return wants_to_walk
