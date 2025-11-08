class_name PlayerTorsoIdleState extends IPlayerTorsoState


func update(input: PlayerInput, delta: float) -> void:
	if input.locomotion_actions.has("shoot"):
		transition.emit("WeaponState")
	elif parent.velocity.length() == 0.0:
		return
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	else:
		transition.emit("RunningState")
