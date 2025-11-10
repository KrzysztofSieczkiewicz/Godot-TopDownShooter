class_name PlayerRootRollState extends IPlayerRootState

@export var SPEED: float = 10
@export var ACCELERATION: float = 1.0
@export var DECELERATION: float = 0.9

func enter(previous_state: IPlayerRootState):
	pass
	# TODO: implement reading last input direction from the previous state to determine initial roll direction 
	# if no direction was set - roll forward
	# opt. give first few frames to determine the direction -> may be left to implement with substates


func update(input: PlayerInput, delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if !input.locomotion_actions.has("roll"):
		transition.emit("GroundedState")
