extends State
class_name Run


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func check_is_relevant(input: InputPackage):
	if input.actions.has("jump") and player.is_on_floor():
		return "jump"
	if input.input_direction == Vector2.ZERO:
		return "idle"
	return "okay"


func update(input: InputPackage, delta: float):
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()


func velocity_by_input(input: InputPackage, delta: float):
	var new_velocity = player.velocity
	
	var direction = (player.transform.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	new_velocity.x = direction.x * SPEED
	new_velocity.z = direction.z * SPEED
	
	if not player.is_on_floor():
		new_velocity.y -= gravity * delta
	
	return new_velocity
