class_name PlayerStateManager extends Node

@onready var root_state_machine: PlayerRootStateMachine = $RootStateMachine
@onready var torso_state_machine: PlayerTorsoStateMachine = $TorsoStateMachine
@onready var locomotion_state_machine: PlayerLocomotionStateMachine = $LocomotionStateMachine

# TODO:
# - implement root state machine or action state machine that allows for states that override the body (Swim, stun, roll)
# - implement roll as a root machine state that is allowed in particular action states (e.g. holding weapon allows, but holding heavy weapon doesn't)
# - make walking toggleable instead of pressable

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	root_state_machine.init(self, parent, animations)
	torso_state_machine.init(self, parent, animations)
	locomotion_state_machine.init(self, parent, animations)

func update(input: PlayerInput, delta: float):
	root_state_machine.update(input, delta)
	var root_constraints = root_state_machine.CURRENT_STATE.torso_constraint
	
	var forced_torso_state: String = root_constraints.forced_state
	if forced_torso_state:
		locomotion_state_machine.force_state(forced_torso_state)
	
	torso_state_machine.update(input, delta)
	var torso_constraints = torso_state_machine.CURRENT_STATE.locomotion_constraint
	
	var forced_locomotion_state: String = torso_constraints.forced_state
	if forced_locomotion_state:
		locomotion_state_machine.force_state(forced_locomotion_state)
	
	var locomotion_input = _handle_locomotion_input_constraints(input, root_constraints)
	locomotion_input = _handle_locomotion_input_constraints(locomotion_input, torso_constraints)
	locomotion_state_machine.update(locomotion_input, delta)

func _handle_locomotion_input_constraints(input: PlayerInput, constraints: IConstraint) -> PlayerInput:
	var filtered_input = input
	
	if constraints.forced_state:
		input.locomotion_actions = [constraints.forced_state]
	else:
		for state in constraints.forbidden_states:
			filtered_input.locomotion_actions.erase(state)
	
	return filtered_input
