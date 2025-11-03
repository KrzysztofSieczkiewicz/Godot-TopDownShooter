extends CharacterBody3D

# TODO:
# - create Animator to handle the input from state machines
# - handle movement speed outside of state machines

@export var SPEED_DEFAULT: float = 5.0
@export var SPEED_CROUCHED: float = 2.0
@export var SPEED_SPRINTING: float = 9.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.5
@export var JUMP_VELOCITY: float = 20

@onready var model = $Model as PlayerModel
@onready var visuals = $Visuals as PlayerVisuals
@onready var input_manager = $InputManager

@onready var COLLIDER_ANIMATOR = $ColliderAnimator ### TODO: Collider animator will be removed later on -> the solution will be to create 3D collision shape matching the character skeleton and then deform them using Character skeleton via RemoteTransform3D or BoneAttachment
@onready var CROUCH_SHAPECAST = $ShapeCast3D ### TODO: Consider if and where should this be moved

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	# Handle the mouse movement by finding intersection between mouse and the world -> TODO: improve
	var level_node = get_parent()
	level_node.connect("mouse_world_intersection", Callable(self, "handle_look_at"))
	
	visuals.accept_skeleton(model.skeleton) # Tie visuals mesh/skin with model skeleton
	CROUCH_SHAPECAST.add_exception($'.') # Exclude player from crouching collision detection

func _physics_process(delta: float) -> void:
	var input = input_manager.detect_input()
	model.update(input, delta)
	
	input.queue_free()
	Global.debug_panel.add_property("Velocity", "%.2f" % velocity.length(), 1)

func handle_look_at(intersection_data: Dictionary) -> void:
	var looking_direction = intersection_data.position
	looking_direction.y = position.y
	
	look_at(looking_direction, Vector3.UP)

func update_gravity(delta: float) -> void:
	var coefficient = 12
	velocity.y = -1 * gravity * delta *  coefficient

func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir = Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func update_velocity() -> void:
	move_and_slide()
