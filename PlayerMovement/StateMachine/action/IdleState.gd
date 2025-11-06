class_name PlayerActionIdleState extends IPlayerActionState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5

func enter(previous_state: IPlayerActionState) -> void:
	animations.play("BasicMovement/Idle")


func update(input: PlayerInput, delta: float) -> void:
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if parent.velocity.length() == 0.0 or !parent.is_on_floor():
		return;
	
	if input.locomotion_actions.has("shoot"):
		transition.emit("WeaponState")
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	else:
		transition.emit("RunningState")
	
	
