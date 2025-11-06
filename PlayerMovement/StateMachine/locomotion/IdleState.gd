class_name PlayerLocomotionIdleState extends IPlayerLocomotionState

@export var SPEED: float = 0.0
@export var ACCELERATION: float = 0.9
@export var DECELERATION: float = 0.9

func enter(previous_state: IPlayerLocomotionState) -> void:
	animations.play("BasicMovement/Idle")


func update(input: PlayerInput, delta: float):
	
	#if !parent.is_on_floor():
	#	return
	
	if input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("run"):
		transition.emit("RunningState")
	
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
