class_name PlayerStateManager extends Node

@onready var root_state_machine: PlayerRootStateMachine = $RootStateMachine
@onready var torso_state_machine: PlayerTorsoStateMachine = $TorsoStateMachine
@onready var locomotion_state_machine: PlayerLocomotionStateMachine = $LocomotionStateMachine

# TODO:
# - make walking toggleable instead of pressable
# - simplify PlayerStateManager update function

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	root_state_machine.init(self, parent, animations)
	torso_state_machine.init(self, parent, animations)
	locomotion_state_machine.init(self, parent, animations)


func update(input: PlayerInput, delta: float):
	root_state_machine.update(input, delta)
	var root_torso_constraints = root_state_machine.CURRENT_STATE.torso_constraint
	var root_locomotion_constraints = root_state_machine.CURRENT_STATE.locomotion_constraint
	
	var forced_torso_state: String = root_torso_constraints.forced_state
	if forced_torso_state:
		locomotion_state_machine.force_state(forced_torso_state)
	
	var torso_input = _handle_input_constraints(input, root_torso_constraints)
	torso_state_machine.update(torso_input, delta)
	var torso_constraints = torso_state_machine.CURRENT_STATE.locomotion_constraint
	
	var forced_root_locomotion_state: String = root_locomotion_constraints.forced_state
	var forced_torso_locomotion_state: String = torso_constraints.forced_state
	if forced_root_locomotion_state:
		locomotion_state_machine.force_state(forced_root_locomotion_state)
	elif forced_torso_locomotion_state:
		locomotion_state_machine.force_state(forced_torso_locomotion_state)
	
	var locomotion_input = _handle_input_constraints(torso_input, root_locomotion_constraints)
	locomotion_input = _handle_input_constraints(locomotion_input, torso_constraints)
	locomotion_state_machine.update(locomotion_input, delta)


func _handle_input_constraints(input: PlayerInput, constraints: IConstraint) -> PlayerInput:
	var filtered_input = input

	for state in constraints.forbidden_states:
		filtered_input.locomotion_actions.erase(state)
	
	return filtered_input
