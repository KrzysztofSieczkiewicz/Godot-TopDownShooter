class_name HumanLocomotionIdleState extends IHumanLocomotionState

@export var SPEED: float = 0.0
@export var ACCELERATION: float = 0.9
@export var DECELERATION: float = 0.9

func enter(previous_state: IHumanLocomotionState) -> void:
	animations.play("BasicMovement/Idle")

func update(input: PlayerInput, delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	for pair in transition_rules:
		if pair.rule.can_transition(parent, input):
			transition.emit(pair.state)
			return
