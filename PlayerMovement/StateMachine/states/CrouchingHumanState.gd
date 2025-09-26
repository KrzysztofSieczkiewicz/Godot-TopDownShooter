class_name CrouchingHumanState extends IMovementState

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var CROUCHING_SPEED: float = 2.0

@onready var CROUCH_SHAPECAST: ShapeCast3D = $"../../ShapeCast3D"

func enter(previous_state: IMovementState) -> void:
	animations.play("BasicMovement/Idle_Crouching", -1.0, CROUCHING_SPEED)
	parent.COLLIDER_ANIMATOR.play("Collider_crouch", -1.0, CROUCHING_SPEED)

func update(delta: float):
	parent.update_gravity(delta)
	parent.update_input(SPEED, ACCELERATION, DECELERATION)
	parent.update_velocity()
	
	if Input.is_action_just_released("crouch"):
		uncrouch()

func uncrouch() -> void:
	if CROUCH_SHAPECAST.is_colliding() == false and Input.is_action_pressed("crouch") == false:
		animations.play("BasicMovement/Idle_Crouching", -1.0, -CROUCHING_SPEED * 1.5, true)
		parent.COLLIDER_ANIMATOR.play("Collider_crouch", -1.0, -CROUCHING_SPEED * 1.5, true)
		if animations.is_playing():
			await animations.animation_finished
		transition.emit("IdleHumanState")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()
