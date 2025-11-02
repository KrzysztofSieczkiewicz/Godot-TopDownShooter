class_name PlayerStateManager extends Node

var action_state_machine: PlayerActionStateMachine
var locomotion_state_machine: PlayerLocomotionStateMachine

# TODO:
# - make walking toggleable instead of pressable
# - make a common method to check condition and emit transition to simplify transition logic in locomotion machine
# - implement interruptions to states
# - remove stance state machine

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	action_state_machine = $ActionStateMachine
	action_state_machine.init(self, parent, animations)
	
	locomotion_state_machine = $LocomotionStateMachine
	locomotion_state_machine.init(self, parent, animations)
