class_name IdleToSprintTransitionRule extends ILocomotionTransitionRule


func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_run = input.locomotion_actions.has("sprint")
	
	return wants_to_run
