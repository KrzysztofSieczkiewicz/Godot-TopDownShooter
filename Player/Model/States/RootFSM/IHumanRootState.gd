class_name IHumanRootState extends Resource

signal transition(new_state_name: StringName)

@export var transition_rules: Array[HumanRootTransitionRuleLink]
@export var locomotion_constraint: IHumanLocomotionConstraint
@export var torso_constraint: IHumanTorsoConstraint

var animations: AnimationPlayer
var parent: CharacterBody3D
var stateManager: PlayerStateManager

func enter(previous_state: IHumanRootState) -> void:
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
