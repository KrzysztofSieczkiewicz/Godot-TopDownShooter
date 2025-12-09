class_name WalkingHumanState extends IMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter(previous_state: IMovementState) -> void:
	animations.play("BasicMovement/Walking")

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	adjust_animation_speed(parent.velocity.length())
	
	if Input.is_action_just_pressed("crouch") and parent.is_on_floor():
		transition.emit("CrouchingHumanState")
		
	if parent.velocity.length() == 0:
		transition.emit("IdleHumanState")
	if Input.is_action_just_pressed("move_sprint"):
		transition.emit("SprintingHumanState")
	
func exit() -> void: 
	animations.speed_scale = 1.0

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
