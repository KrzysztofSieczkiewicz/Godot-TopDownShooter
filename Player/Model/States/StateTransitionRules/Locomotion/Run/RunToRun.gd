class_name RunToRunTransitionRule extends IHumanLocomotionTransitionRule

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_sprint = input.locomotion_actions.has("run")
	
	return wants_to_sprint
