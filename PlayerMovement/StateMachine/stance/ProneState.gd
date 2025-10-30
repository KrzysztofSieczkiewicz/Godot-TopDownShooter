class_name PlayerStanceProneState extends IPlayerStanceState

@onready var PRONE_SHAPECAST: ShapeCast3D = $"../../../ShapeCast3D"

func can_transition_to_locomotion(next_state: StringName) -> bool:
	if next_state == "SprintingState":
		return false
	else:
		return true

func update(delta: float):
	if Input.is_action_just_pressed("prone"):
		stand_up()
	elif Input.is_action_pressed("crouch"):
		crouch()

func stand_up() -> void:
	if PRONE_SHAPECAST.is_colliding() == false:
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
