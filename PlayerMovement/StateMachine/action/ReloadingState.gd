class_name PlayerActionReloadingState extends IPlayerActionState

func enter(IPlayerActionState):
	await get_tree().create_timer(5).timeout
	transition.emit("IdleState")
