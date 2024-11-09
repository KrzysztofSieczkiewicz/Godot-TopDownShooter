extends Node
class_name InputGatherer


func get_current_input() -> InputPackage:
	var new_input = InputPackage.new()
	
	if Input.is_action_just_pressed("move_jump"):
		new_input.actions.append("jump")
	
	new_input.input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("run")
	
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	return new_input
