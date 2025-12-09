class_name IHumanTorsoState extends Resource

signal transition(new_state_name: StringName)

@export var transition_rules: Array[HumanTorsoTransitionRuleLink]
@export var locomotion_constraint: IHumanLocomotionConstraint

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IHumanTorsoState) -> void:
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
