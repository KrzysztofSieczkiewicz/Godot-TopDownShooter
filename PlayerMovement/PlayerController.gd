extends CharacterBody3D

@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 20

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var _is_crouching: bool = false

func _ready() -> void:
	var level_node = get_parent()
	level_node.connect("mouse_world_intersection", Callable(self, "handle_look_at"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crouch"):
		toggle_crouching()

func _physics_process(delta: float) -> void:
	
	handle_gravity_and_jump(delta)
	handle_movement()

	move_and_slide()

func handle_gravity_and_jump(delta: float) -> void:
	# Handle gravity
	if not is_on_floor():
		velocity.y = - gravity * delta * 12
	
	# Handle jump
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func handle_movement() -> void:
	var input_dir = Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func handle_look_at(intersection_data: Dictionary) -> void:
	var looking_direction = intersection_data.position
	looking_direction.y = position.y
	
	look_at(looking_direction, Vector3.UP)

func toggle_crouching() -> void:
	if _is_crouching == true:
		print("I was crouching, standing now")
	elif _is_crouching == false:
		print("I was standing, crouching now")
	_is_crouching = !_is_crouching
