class_name HumanTorsoWeaponState extends IHumanTorsoState

func enter(previous_state: IHumanTorsoState) -> void:
	pass

func update(input: PlayerInput, delta: float):
	execute_transition_rules(input)
