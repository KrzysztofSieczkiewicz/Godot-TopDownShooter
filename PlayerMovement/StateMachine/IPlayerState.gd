class_name IPlayerState extends Node

func enter(previous_state: IPlayerState) -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func handle_input(input: PlayerInput) -> IPlayerState:
	return self
