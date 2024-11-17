extends State 
class_name JumpRun

const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	animation = "BasicMovement/Running_Jump"

func check_transition(input: InputPackage):
	if works_longer_than(0.1):
		return "midair"
	
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"

func update(input, delta):
	player.velocity.y -= gravity * delta
	player.move_and_slide()

func on_state_enter():
	player.velocity.y = JUMP_VELOCITY
