class_name PlayerLocomotionIdleState extends IPlayerLocomotionState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter(previous_state: IPlayerLocomotionState) -> void:
	#animations.play("BasicMovement/Idle")
	pass

func update(constraint: ILocomotionConstraint, delta: float):
	#parent.update_gravity(delta)
	#parent.update_input(SPEED, ACCELERATION, DECELERATION)
	#parent.update_velocity()
	var input: PlayerInput = constraint.get_filtered_input();
	push_error(input.locomotion_actions)
	
	if parent.velocity.length() == 0.0 or !parent.is_on_floor():
		return
	
	if input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	else:
		transition.emit("RunningState")
