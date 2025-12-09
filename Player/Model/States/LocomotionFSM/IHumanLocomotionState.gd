class_name IHumanLocomotionState extends Resource

signal transition(new_state_key: HumanStates.LOCOMOTION_STATE)

@export var transition_rules: Array[HumanLocomotionTransitionRuleLink]

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IHumanLocomotionState) -> void:
	pass

func exit() -> void:
	pass

func update(input: PlayerInput, delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func execute_transition_rules(input: PlayerInput):
	for pair in transition_rules:
		if pair.rule.can_transition(parent, input):
			transition.emit(pair.state)
			return
