class_name PlayerStateManager extends Node

var action_state_machine: PlayerActionStateMachine
var locomotion_state_machine: PlayerLocomotionStateMachine

# TODO:
# - consider how to implement roll as a locomotion state that is allowed in particular action states (e.g. holding weapon allows, but holding heavy weapon doesn't)
# - make walking toggleable instead of pressable


func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	action_state_machine = $ActionStateMachine
	action_state_machine.init(self, parent, animations)
	
	locomotion_state_machine = $LocomotionStateMachine
	locomotion_state_machine.init(self, parent, animations)

func update(input: PlayerInput, delta: float):
	action_state_machine.update(input, delta)
	var constraints = action_state_machine.CURRENT_STATE.locomotion_constraint;
	var locomotion_input = _filter_constrained_inputs(input, constraints)
	locomotion_state_machine.update(locomotion_input, delta)


func _filter_constrained_inputs(input: PlayerInput, constraints: ILocomotionConstraint) -> PlayerInput:
	var filtered_input = input
	for state in constraints.forbidden_states:
		filtered_input.locomotion_actions.erase(state)
	
	return filtered_input
