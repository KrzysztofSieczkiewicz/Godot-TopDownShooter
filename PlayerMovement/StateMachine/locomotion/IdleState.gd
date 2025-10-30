class_name PlayerLocomotionIdleState extends IPlayerLocomotionState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter(previous_state: IPlayerLocomotionState) -> void:
	animations.play("BasicMovement/Idle")

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if parent.velocity.length() > 0.0 and parent.is_on_floor():
		if Input.is_action_pressed("move_walk"):
			transition.emit("WalkingState")
		elif Input.is_action_pressed("move_sprint"):
			transition.emit("SprintingState")
		else:
			transition.emit("RunningState")
	
