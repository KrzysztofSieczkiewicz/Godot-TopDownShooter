class_name HumanLocomotionIdleState extends IHumanLocomotionState

@export var SPEED: float = 0.0
@export var ACCELERATION: float = 0.9
@export var DECELERATION: float = 0.9

func enter(previous_state: IPlayerLocomotionState) -> void:
	animations.play("BasicMovement/Idle")

func update(input: PlayerInput, delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	for rule in transition_rules:
		push_error("I DETECT TRANSITION RULES")
		if rule.can_transition(parent, input):
			transition.emit(transition_rules[rule])
			return
