class_name PlayerLocomotionWalkingState extends IPlayerLocomotionState
"""
@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter(previous_state: IPlayerLocomotionState) -> void:
	animations.play("BasicMovement/Walking")

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	adjust_animation_speed(parent.velocity.length())
	
	if parent.velocity.length() == 0:
		transition.emit("IdleState")
	if Input.is_action_just_released("move_walk"):
		transition.emit("RunningState")
	if Input.is_action_pressed("move_sprint"):
		transition.emit("SprintingState")
	
func exit() -> void: 
	animations.speed_scale = 1.0

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
"""
