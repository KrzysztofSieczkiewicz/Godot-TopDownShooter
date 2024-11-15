extends State
class_name Run


const SPEED = 4.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	animation = "BasicMovement/Running"

func check_transition(input: InputPackage):
	input.actions.sort_custom(moves_priority_sort)
	
	if input.actions[0] == "run":
		return "okay"
	
	return input.actions[0]


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
