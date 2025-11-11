class_name WalkToSprintTransitionRule extends ILocomotionTransitionRule

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_sprint = input.locomotion_actions.has("sprint")
	var has_stamina = true # TODO: add a parent check for stamina
	
	return wants_to_sprint and has_stamina
