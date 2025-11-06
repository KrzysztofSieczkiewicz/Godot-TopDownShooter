class_name PlayerLocomotionWalkingState extends IPlayerLocomotionState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter(previous_state: IPlayerLocomotionState) -> void:
	#animations.play("BasicMovement/Walking")
	pass

func update(constraint: ILocomotionConstraint, delta: float):
	#parent.update_gravity(delta)
	#parent.update_input(SPEED, ACCELERATION, DECELERATION)
	#parent.update_velocity()
	
	#adjust_animation_speed(parent.velocity.length())
	
	var input: PlayerInput = constraint.get_filtered_input();
	
	if parent.velocity.length() == 0:
		transition.emit("IdleState")
	elif input.locomotion_actions.has("walk"):
		return
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("run"):
		transition.emit("RunningState")
	
func exit() -> void: 
	animations.speed_scale = 1.0

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
