extends Node
class_name InputHandler


func get_current_input() -> InputPackage:
	var new_input = InputPackage.new()
	
	### Handle movement
	new_input.input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if new_input.input_direction != Vector2.ZERO:
		if Input.is_action_pressed("move_run"):
			new_input.actions.append(GlobalStates.HumanoidStates.RUN)
		else:
			new_input.actions.append(GlobalStates.HumanoidStates.WALK)
	
	### Handle jump
	#if Input.is_action_just_pressed("move_jump"):
	#	if new_input.input_direction == Vector2.ZERO:
	#		new_input.actions.append("jump_idle")
	#	elif new_input.actions.has("walk"):
	#		new_input.actions.append("jump_idle")
	#	else: #new_input.actions.has("run"):
	#		new_input.actions.append("jump_run")
	
	### Handle idle
	if new_input.actions.is_empty():
		new_input.actions.append(GlobalStates.HumanoidStates.IDLE)
	
	return new_input
