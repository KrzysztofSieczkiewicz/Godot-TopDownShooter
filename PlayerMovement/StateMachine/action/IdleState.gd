class_name PlayerActionIdleState extends IPlayerActionState

func can_transition_to_locomotion(next_state: IPlayerLocomotionState) -> bool:
	return true; # All locomotion states are allowed

func enter(previous_state: IPlayerActionState) -> void:
	animations.play("BasicMovement/Idle")
