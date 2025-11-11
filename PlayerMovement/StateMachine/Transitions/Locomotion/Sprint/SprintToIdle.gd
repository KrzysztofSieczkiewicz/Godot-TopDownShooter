class_name SprintToIdleTransitionRule extends ILocomotionTransitionRule

const VELOCITY_THRESHOLD : float = 0.1

func can_transition(parent: CharacterBody3D, input: PlayerInput) -> bool:
	var input_released = input.locomotion_actions.has("idle")
	var is_stopped = parent.velocity.length() < VELOCITY_THRESHOLD
	
	return input_released and is_stopped
