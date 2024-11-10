extends Node
class_name InputGatherer


func get_current_input() -> InputPackage:
	var new_input = InputPackage.new()
	
	new_input.input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("run")
		
	if Input.is_action_just_pressed("move_jump"):
		if new_input.actions.has("sprint"):
			new_input.actions.append("sprint_jump")
		else:
			new_input.actions.append("run_jump")
	
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	return new_input
