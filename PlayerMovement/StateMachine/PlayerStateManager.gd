class_name PlayerStateManager extends Node

var action_state_machine: PlayerActionStateMachine
var locomotion_state_machine: PlayerLocomotionStateMachine

# TODO:
# - make walking toggleable instead of pressable
# - implement interruptions to states

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	action_state_machine = $ActionStateMachine
	action_state_machine.init(self, parent, animations)
	
	locomotion_state_machine = $LocomotionStateMachine
	locomotion_state_machine.init(self, parent, animations)

func update(input: PlayerInput, delta: float):
	action_state_machine.update(input, delta)
	var constraint = action_state_machine.CURRENT_STATE.locomotion_constraint;
	constraint.filter_player_input(input) # TODO: shouldn't be explicitly called
	locomotion_state_machine.update(constraint, delta)
