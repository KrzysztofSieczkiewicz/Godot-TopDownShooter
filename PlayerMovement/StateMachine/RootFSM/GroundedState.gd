class_name PlayerRootGroundedState extends IPlayerRootState

func update(input: PlayerInput, delta: float):
	if input.locomotion_actions.has("roll"):
		transition.emit("RollState")
