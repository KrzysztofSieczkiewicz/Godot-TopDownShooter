class_name WeaponToIdleTransitionRule extends ITorsoTransitionRule


func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_run = not input.locomotion_actions.has("shoot")
	
	return wants_to_run
