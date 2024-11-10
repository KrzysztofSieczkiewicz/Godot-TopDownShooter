extends State
class_name Idle


func check_is_relevant(input) -> String:
	input.actions.sort_custom(moves_priority_sort)
	return input.actions[0]
	
func on_state_enter():
	player.velocity = Vector3.ZERO

	#if input.actions.has("jump"):
		#return "jump"
	#if input.input_direction != Vector2.ZERO:
		#return "run"
	#return "okay"
