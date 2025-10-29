class_name PlayerStanceStandingState extends IPlayerStanceState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var CROUCHING_SPEED: float = 2.0

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if Input.is_action_pressed("crouch"):
		transition.emit("CrouchingState")
	elif Input.is_action_just_pressed("prone"):
		transition.emit("ProneState")
