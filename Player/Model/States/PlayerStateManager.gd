class_name PlayerStateManager extends Node

@onready var root_state_machine: PlayerRootStateMachine = $RootStateMachine
@onready var torso_state_machine: PlayerTorsoStateMachine = $TorsoStateMachine
@onready var locomotion_state_machine: PlayerLocomotionStateMachine = $LocomotionStateMachine

# TODO:
# - simplify PlayerStateManager update function


func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	root_state_machine.init(self, parent, animations)
	torso_state_machine.init(self, parent, animations)
	locomotion_state_machine.init(self, parent, animations)


func update(input: PlayerInput, delta: float):
	# UPDATE THE ROOT STATE
	root_state_machine.update(input, delta)
	var root_state = root_state_machine.CURRENT_STATE
	var r_torso_c = root_state.torso_constraint
	var r_loco_c = root_state.locomotion_constraint
	
	# APLLY ROOT CONSTRAINTS AND FILTERS
	_handle_forced_torso_state(r_torso_c)
	var torso_input = _filter_input_constraints(input, r_torso_c) 
	
	# UPDATE TORSO STATE
	var torso_state = torso_state_machine.CURRENT_STATE
	torso_state_machine.update(torso_input, delta)
	var t_loco_c = torso_state.locomotion_constraint
	
	# APPLY TORSO CONSTRAINTS AND FILTERS
	_handle_forced_locomotion_state(r_loco_c, t_loco_c)
	var locomotion_input = _filter_input_constraints(torso_input, r_loco_c)
	locomotion_input = _filter_input_constraints(locomotion_input, t_loco_c)
	
	# UPDATE LOCOMOTION STATE
	locomotion_state_machine.update(locomotion_input, delta)


func _filter_input_constraints(input: PlayerInput, constraints) -> PlayerInput:
	var filtered_input = input
	for input_to_remove in constraints.forbidden_inputs:
		filtered_input.locomotion_actions.erase(input_to_remove)	
	return filtered_input


func _handle_forced_locomotion_state(root_constraints, torso_constraints) -> bool:
	var forced_root = root_constraints.forced_state
	var forced_torso = torso_constraints.forced_state

	if forced_root:
		locomotion_state_machine.force_state(forced_root)
		return true
	elif forced_torso:
		locomotion_state_machine.force_state(forced_torso)
		return true
	return false


func _handle_forced_torso_state(root_constraints) -> bool:
	var forced_torso_state = root_constraints.forced_state
	if forced_torso_state:
		torso_state_machine.force_state(forced_torso_state)
		return true
	return false
