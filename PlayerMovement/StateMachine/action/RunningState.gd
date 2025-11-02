class_name PlayerActionRunningState extends IPlayerActionState

@export var SPEED: float = 7.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter(IPlayerActionState):
	animations.play("BasicMovement/Sprinting")
	stateManager.switch_locomotion_to(locomotion_state)

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	adjust_animation_speed(parent.velocity.length())
	
	if Input.is_action_just_pressed("move_walk"):
		transition.emit("WalkingState")
	elif Input.is_action_pressed("move_sprint"):
		transition.emit("SprintingState")
	if parent.velocity.length() == 0:
		transition.emit("IdleState")

func exit() -> void: 
	animations.speed_scale = 1.0

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
