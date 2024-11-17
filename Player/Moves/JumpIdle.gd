extends State
class_name IdleJump

const TRANSITION_TIME = 0.5
const JUMP_TIMING = 0.1
const JUMP_VELOCITY = 3.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var jumped: bool = false


func _ready():
	animation = "BasicMovement/Idle_Jump"


func check_transition(input: InputPackage):
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"

func update(input, delta):
	player.velocity.y -= gravity * delta
	player.move_and_slide()

func on_state_enter():
	player.velocity.y = JUMP_VELOCITY
