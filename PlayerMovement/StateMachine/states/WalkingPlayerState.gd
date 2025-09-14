class_name WalkingHumanState

extends IState

func update(delta: float):
	if parent.velocity.length() == 0.0:
		transition.emit("IdleHumanState")
