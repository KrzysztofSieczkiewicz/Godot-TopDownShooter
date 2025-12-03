class_name HumanLocomotionSprintingState extends IHumanLocomotionState

@export var SPEED: float = 10.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter(previous_state: IPlayerLocomotionState) -> void:
	animations.play("BasicMovement/Sprinting")


func update(input: PlayerInput, delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	adjust_animation_speed(parent.velocity.length())
	
	for rule in transition_rules:
		if rule.can_transition(parent, input):
			transition.emit(transition_rules[rule])

func exit() -> void: 
	animations.speed_scale = 1.0

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
