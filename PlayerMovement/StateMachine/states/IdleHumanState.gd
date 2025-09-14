class_name IdleHumanState

extends IState

func update(delta: float):
	if parent.velocity.length() > 0.0:
		transition.emit("WalkingHumanState")
