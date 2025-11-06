class_name PlayerActionWeaponState extends IPlayerActionState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter(IPlayerActionState):
	#TODO: ADD HERE - read the currently equipped weapon and get it's current substate LocomotionConstraint -> then overwrite the current LocomotionConstraint
	
	animations.play("BasicMovement/Sprinting")

func update(input: PlayerInput, delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	adjust_animation_speed(parent.velocity.length())
	
	if input.locomotion_actions.has("shoot"):
		return
	elif input.locomotion_actions.has("sprint"):
		transition.emit("SprintingState")
	elif input.locomotion_actions.has("walk"):
		transition.emit("WalkingState")
	elif input.locomotion_actions.has("run"):
		transition.emit("RunningState")
	elif parent.velocity.length() == 0:
		transition.emit("IdleState")

func exit() -> void: 
	animations.speed_scale = 1.0

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
