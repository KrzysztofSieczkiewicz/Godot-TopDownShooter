class_name SprintToRunTransitionRule extends IHumanLocomotionTransitionRule

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_run = input.locomotion_actions.has("run")
	
	return wants_to_run
