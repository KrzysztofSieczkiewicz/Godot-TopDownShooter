class_name PlayerStanceCrouchingState extends IPlayerStanceState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var CROUCHING_SPEED: float = 2.0

@onready var CROUCH_SHAPECAST: ShapeCast3D = $"../../../ShapeCast3D"

func can_transition_to_locomotion(next_state: StringName) -> bool:
	if next_state == "SprintingState":
		return false
	else:
		return true
		
func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
	elif Input.is_action_pressed("prone"):
		transition.emit("ProneStance")

func uncrouch() -> void:
	if CROUCH_SHAPECAST.is_colliding() == false and Input.is_action_pressed("crouch") == false:
		transition.emit("StandingState")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()
