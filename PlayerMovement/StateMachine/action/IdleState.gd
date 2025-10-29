class_name PlayerActionIdleState extends IPlayerActionState

func enter(previous_state: IPlayerActionState) -> void:
	animations.play("BasicMovement/Idle")
