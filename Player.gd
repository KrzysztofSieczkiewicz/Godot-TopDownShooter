extends CharacterBody3D

@onready var gunController = $GunController

const SPEED = 7.5
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):

	# Add the gravity.
	# TODO: enable later
	#if not is_on_floor():
	#	velocity.y -= gravity * delta

	# Handle movement inputwww
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Handle jump input
	# TODO: replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle shooting input
	if Input.is_action_pressed("shoot"):
		gunController.shoot()
	
	move_and_slide()
