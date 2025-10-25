class_name PlayerActionIdleState extends IPlayerActionState

func can_transition_to_locomotion(next_state: Script) -> bool:
	return true; # All locomotion is allowed
