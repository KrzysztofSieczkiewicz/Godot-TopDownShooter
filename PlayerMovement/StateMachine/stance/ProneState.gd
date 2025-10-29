class_name PlayerStanceProneState extends IPlayerStanceState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var CROUCHING_SPEED: float = 2.0

@onready var PRONE_SHAPECAST: ShapeCast3D = $"../../../ShapeCast3D"

func can_transition_to_locomotion(next_state: IPlayerLocomotionState) -> bool:
	if next_state is PlayerLocomotionSprintingState:
		return false
	else:
		return true

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if Input.is_action_just_pressed("prone"):
		stand_up()
	elif Input.is_action_pressed("crouch"):
		crouch()

func stand_up() -> void:
	if PRONE_SHAPECAST.is_colliding() == false and Input.is_action_pressed("prone") == false:
		transition.emit("StandingState")
	elif PRONE_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		stand_up()

func crouch() -> void:
	if PRONE_SHAPECAST.is_colliding() == false and Input.is_action_pressed("prone") == false:
		transition.emit("CrouchingState")
	elif PRONE_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		stand_up()
