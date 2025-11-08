class_name PlayerTorsoSprintingState extends IPlayerTorsoState


func update(input: PlayerInput, delta: float):
	if input.locomotion_actions.has("shoot"):
		transition.emit("WeaponState")
	elif input.locomotion_actions.has("sprint"):
		return
	elif input.locomotion_actions.has("run"):
		transition.emit("RunningState")
	elif input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	else:
		transition.emit("IdleState")
