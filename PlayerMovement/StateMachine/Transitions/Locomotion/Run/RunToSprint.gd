class_name RunToSprintTransitionRule extends ILocomotionTransitionRule

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_sprint = input.locomotion_actions.has("sprint")
	
	return wants_to_sprint
