extends IState
class_name Walk


const WALKING_SPEED: float = 2.0


func _ready():
	animation = "BasicMovement/Walking"


func check_transition(input: InputPackage):
	input.actions.sort_custom(moves_priority_sort)
	
	if input.actions[0] == GlobalStates.HumanoidStates.WALK:
		return GlobalStates.HumanoidStates.ONGOING
		
	return input.actions[0]


func update(input: InputPackage, delta: float):
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()


func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	var new_velocity = player.velocity
	
	var direction = (player.transform.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	new_velocity.x = direction.x * WALKING_SPEED
	new_velocity.z = direction.z * WALKING_SPEED

	return new_velocity
