class_name PlayerTorsoRunningState extends IPlayerTorsoState


func update(input: PlayerInput, delta: float):
	if input.locomotion_actions.has("shoot"):
		transition.emit("WeaponState")
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	elif parent.velocity.length() == 0:
		transition.emit("IdleState")
	elif input.locomotion_actions.has("run"):
		return
