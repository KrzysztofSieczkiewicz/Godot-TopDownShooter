class_name PlayerStanceStandingState extends IPlayerStanceState

func update(delta: float):
	
	if Input.is_action_pressed("crouch"):
		transition.emit("CrouchingState")
	elif Input.is_action_just_pressed("prone"):
		transition.emit("ProneState")
