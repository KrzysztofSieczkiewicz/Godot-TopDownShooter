class_name IdleHumanState extends IMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter() -> void:
	animations.play("BasicMovement/Idle")

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if Input.is_action_just_pressed("crouch") and parent.is_on_floor():
		transition.emit("CrouchingHumanState")
	
	if parent.velocity.length() > 0.0 and parent.is_on_floor():
		transition.emit("WalkingHumanState")
