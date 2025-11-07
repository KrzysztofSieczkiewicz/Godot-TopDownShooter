class_name PlayerStateManager extends Node

var action_state_machine: PlayerActionStateMachine
var locomotion_state_machine: PlayerLocomotionStateMachine

# TODO:
# - implement roll as a locomotion state that is allowed in particular action states (e.g. holding weapon allows, but holding heavy weapon doesn't)
# - make walking toggleable instead of pressable


func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	action_state_machine = $ActionStateMachine
	action_state_machine.init(self, parent, animations)
	
	locomotion_state_machine = $LocomotionStateMachine
	locomotion_state_machine.init(self, parent, animations)

func update(input: PlayerInput, delta: float):
	action_state_machine.update(input, delta)
	var constraints = action_state_machine.CURRENT_STATE.locomotion_constraint;
	
	var forced_locomotion_state: String = constraints.forced_state
	if forced_locomotion_state:
		locomotion_state_machine.force_state(forced_locomotion_state)
	
	var locomotion_input = _handle_locomotion_input_constraints(input, constraints)
	locomotion_state_machine.update(locomotion_input, delta)

func _handle_locomotion_input_constraints(input: PlayerInput, constraints: ILocomotionConstraint) -> PlayerInput:
	var filtered_input = input
	
	if constraints.forced_state:
		input.locomotion_actions = [constraints.forced_state]
	else:
		for state in constraints.forbidden_states:
			filtered_input.locomotion_actions.erase(state)
	
	return filtered_input
