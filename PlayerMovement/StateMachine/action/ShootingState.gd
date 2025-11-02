class_name PlayerActionShootingState extends IPlayerActionState

func update(delta: float):
	if Input.is_action_just_pressed("reload"):
		transition.emit("ReloadingState")
	
	if Input.is_action_just_released("shoot"):
		transition.emit("IdleState")
