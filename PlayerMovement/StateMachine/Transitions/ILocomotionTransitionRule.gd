class_name ILocomotionTransitionRule extends Resource

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	push_error("can_transition for ITransitionRule should be implemented")
	return false
