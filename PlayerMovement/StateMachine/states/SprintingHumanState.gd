class_name SprintingHumanState extends IMovementState

@export var SPEED: float = 9.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter() -> void:
	animations.play("BasicMovement/Sprinting")

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	adjust_animation_speed(parent.velocity.length())
	if Input.is_action_just_released("move_sprint"):
		transition.emit("WalkingHumanState")
	if parent.velocity.length() == 0:
		transition.emit("IdleHumanState")

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)	
