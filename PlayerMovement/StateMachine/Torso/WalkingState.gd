class_name PlayerTorsoWalkingState extends IPlayerTorsoState


func update(input: PlayerInput, delta: float):
	if input.locomotion_actions.has("shoot"):
		transition.emit("WeaponState")
	elif parent.velocity.length() == 0:
		transition.emit("IdleState")
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("walk"):
		return
	elif input.locomotion_actions.has("run"):
		transition.emit("RunningState")
