class_name PlayerActionWeaponState extends IPlayerActionState


func enter(IPlayerActionState):
	#TODO: ADD HERE - read the currently equipped weapon and get it's current substate LocomotionConstraint -> then overwrite the current LocomotionConstraint	
	pass


func update(input: PlayerInput, delta: float):
	if input.locomotion_actions.has("shoot"):
		return
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	elif input.locomotion_actions.has("run"):
		transition.emit("RunningState")
	elif parent.velocity.length() == 0:
		transition.emit("IdleState")
