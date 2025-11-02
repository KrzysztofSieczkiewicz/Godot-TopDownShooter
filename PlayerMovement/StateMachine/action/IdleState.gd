class_name PlayerActionIdleState extends IPlayerActionState

func enter(previous_state: IPlayerActionState) -> void:
	animations.play("BasicMovement/Idle")

func update(delta: float):
	if Input.is_action_pressed("shoot"):
		transition.emit("ShootingState")
	if Input.is_action_just_pressed("reload"):
		transition.emit("ReloadingState")
