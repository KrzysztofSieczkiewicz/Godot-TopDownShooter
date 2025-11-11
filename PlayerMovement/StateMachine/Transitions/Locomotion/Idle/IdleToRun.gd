class_name IdleToRunTransitionRule extends ILocomotionTransitionRule


func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_run = input.locomotion_actions.has("run")
	var can_move = parent.is_on_floor()
	
	return wants_to_run and can_move
