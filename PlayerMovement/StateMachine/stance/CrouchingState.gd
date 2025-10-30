class_name PlayerStanceCrouchingState extends IPlayerStanceState

@onready var CROUCH_SHAPECAST: ShapeCast3D = $"../../../ShapeCast3D"

func can_transition_to_locomotion(next_state: StringName) -> bool:
	if next_state == "SprintingState":
		return false
	else:
		return true
		
func update(delta: float):
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
