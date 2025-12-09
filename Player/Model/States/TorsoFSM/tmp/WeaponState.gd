class_name HumanTorsoWeaponState extends IHumanTorsoState

func enter(previous_state: IPlayerTorsoState) -> void:
	pass

func update(input: PlayerInput, delta: float):
	for rule in transition_rules:
		if rule.can_transition(parent, input):
			transition.emit(transition_rules[rule])
