class_name PlayerStateManager extends Node

var action_state_machine: PlayerActionStateMachine
var locomotion_state_machine: PlayerLocomotionStateMachine

# TODO:
# - make walking toggleable instead of pressable
# - make a common method to check condition and emit transition to simplify transition logic in locomotion machine
# - implement interruptions to states
# - remove this layer - currently the machines are not really parallel, 
#	actions are determining the rest so the ActionsStateMachine should be on the top making this manager redundant

func init(parent: CharacterBody3D, animations: AnimationPlayer) -> void:
	action_state_machine = $ActionStateMachine
	action_state_machine.init(self, parent, animations)
	
	locomotion_state_machine = $LocomotionStateMachine
	locomotion_state_machine.init(self, parent, animations)

func update(input: PlayerInput, delta: float):
	action_state_machine.CURRENT_STATE.update(input, delta)

func switch_locomotion_to(new_locomotion: IPlayerLocomotionState):
	if locomotion_state_machine:
		locomotion_state_machine.switch_to(new_locomotion)
