class_name IdleToWeaponTransitionRule extends ITorsoTransitionRule


func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_run = input.locomotion_actions.has("shoot")
	
	return wants_to_run
