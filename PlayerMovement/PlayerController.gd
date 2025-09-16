extends CharacterBody3D

@export var SPEED_DEFAULT: float = 5.0
@export var SPEED_CROUCHED: float = 2.0
@export var SPEED_SPRINTING: float = 9.0
@export var ACCELERATION: float = 0.1
@export var DECCELERATION: float = 0.5
@export var TOGGLE_CROUCH: bool = true
@export var JUMP_VELOCITY: float = 20

@onready var model = $Model as PlayerModel
@onready var visuals = $Visuals as PlayerVisuals
@onready var stateMachine = $HumanStateMachine

@onready var COLLIDER_ANIMATOR = $ColliderAnimator ### TODO: Collider animator will be removed later on -> the solution will be to create 3D collision shape matching the character skeleton and then deform them using Character skeleton via RemoteTransform3D or BoneAttachment
@onready var CROUCH_SHAPECAST = $ShapeCast3D ### TODO: Consider if and where should this be moved

var _speed: float

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var _is_crouching: bool = false
const crouching_speed = 7.0

func _ready() -> void:
	var level_node = get_parent()
	level_node.connect("mouse_world_intersection", Callable(self, "handle_look_at"))
	
	# Tie visuals mesh/skin with model skeleton
	visuals.accept_skeleton(model.skeleton)
	
	# Exclude player from collision detection
	CROUCH_SHAPECAST.add_exception($'.')
	
	# Initialize state machine with player and animator reference
	stateMachine.init(self, model.animator)
	
	# Set default movement speed
	_speed = SPEED_DEFAULT


func _physics_process(delta: float) -> void:
	Global.debug_panel.add_property("PlayerMovementSpeed", _speed, 1)
	
	handle_gravity_and_jump(delta)
	handle_movement()

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crouch") and is_on_floor() and TOGGLE_CROUCH == true:
		toggle_crouch()
	elif event.is_action_pressed("crouch") and TOGGLE_CROUCH == false and _is_crouching == false and is_on_floor():
		crouching(true)
	elif event.is_action_released("crouch") and TOGGLE_CROUCH == false and _is_crouching == true:
		uncrouch_check()


func handle_gravity_and_jump(delta: float) -> void:
	# Handle gravity
	if not is_on_floor():
		velocity.y = - gravity * delta * 12
	
	# Handle jump
	if Input.is_action_just_pressed("move_jump") and is_on_floor() and _is_crouching == false:
		velocity.y = JUMP_VELOCITY


func handle_movement() -> void:
	var input_dir = Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * _speed, ACCELERATION)
		velocity.z = lerp(velocity.z, direction.z * _speed, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECCELERATION)
		velocity.z = move_toward(velocity.z, 0, DECCELERATION)


func handle_look_at(intersection_data: Dictionary) -> void:
	var looking_direction = intersection_data.position
	looking_direction.y = position.y
	
	look_at(looking_direction, Vector3.UP)

func toggle_crouch() -> void:
	if _is_crouching == true and CROUCH_SHAPECAST.is_colliding() == false:
		crouching(false)
	elif _is_crouching == false:
		crouching(true)

func uncrouch_check() -> void:
	if CROUCH_SHAPECAST.is_colliding() == false:
		crouching(false)
	else:
		await get_tree().create_timer(0.1).timeout
		uncrouch_check()

func crouching(state: bool) -> void:
	match state:
		true:
			COLLIDER_ANIMATOR.play("Collider_crouch", -1, crouching_speed)
			set_movement_speed("crouched")
		false:
			COLLIDER_ANIMATOR.play("Collider_crouch",-1, -crouching_speed, true)
			set_movement_speed("default")
	_is_crouching = !_is_crouching

func set_movement_speed(state: String):
	match state:
		"default":
			_speed = SPEED_DEFAULT
		"crouched":
			_speed = SPEED_CROUCHED
