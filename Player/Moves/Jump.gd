extends State
class_name Jump

const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	animation = "idle"

func check_is_relevant(input: InputPackage):
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"

	
func update(input, delta):
	player.velocity.y -= gravity * delta
	player.move_and_slide()


func on_state_enter():
	player.velocity.y = JUMP_VELOCITY
