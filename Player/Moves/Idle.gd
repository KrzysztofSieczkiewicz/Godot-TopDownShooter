extends IState
class_name Idle

func _ready():
	animation = "BasicMovement/Idle"


func check_transition(input):
	input.actions.sort_custom(moves_priority_sort)
	return input.actions[0]

	
func on_state_enter():
	player.velocity = Vector3.ZERO
