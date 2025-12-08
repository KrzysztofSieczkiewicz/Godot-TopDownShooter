class_name IdleToWalkTransitionRule extends IHumanLocomotionTransitionRule


func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_run = input.locomotion_actions.has("walk")
	
	return wants_to_run
