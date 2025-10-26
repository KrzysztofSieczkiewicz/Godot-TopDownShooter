class_name PlayerStateManager extends Node

var stance_state_machine: PlayerStanceStateMachine
var action_state_machine: PlayerActionStateMachine
var locomotion_state_machine: PlayerLocomotionStateMachine

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	stance_state_machine = $StanceStateMachine
	stance_state_machine.init(parent, animations)
	
	action_state_machine = $ActionStateMachine
	action_state_machine.init(parent, animations)
	
	locomotion_state_machine = $LocomotionStateMachine
	locomotion_state_machine.init(parent, animations)


func can_transition_to_locomotion(new_locomotion_state: IPlayerLocomotionState) -> bool:
	if not stance_state_machine.CURRENT_STATE.can_transition_to_locomotion(new_locomotion_state):
		return false
	if not action_state_machine.CURRENT_STATE.can_transition_to_locomotion(new_locomotion_state):
		return false
	
	return true


func can_transition_to_action(new_action_state: IPlayerActionState) -> bool:
	if not stance_state_machine.CURRENT_STATE.can_transition_to_action(new_action_state):
		return false
	else:
		return true
