class_name PlayerActionSprintingState extends IPlayerActionState


func enter(previous_state: IPlayerActionState) -> void:
	pass


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
