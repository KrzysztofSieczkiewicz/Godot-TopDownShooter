class_name WeaponToIdleTransitionRule extends IHumanTorsoTransitionRule


func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var wants_to_stop_shooting = !input.locomotion_actions.has("shoot")
	
	return wants_to_stop_shooting
