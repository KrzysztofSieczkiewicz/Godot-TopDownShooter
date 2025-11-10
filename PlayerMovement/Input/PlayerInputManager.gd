class_name PlayerInputManager extends Node

func detect_input() -> PlayerInput:
	var new_input = PlayerInput.new()
	
	new_input.locomotion_actions.append("idle")
	
	new_input.input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if new_input.input_direction != Vector2.ZERO:
		new_input.locomotion_actions.append("run")
		if Input.is_action_pressed("move_sprint"):
			new_input.locomotion_actions.append("sprint")
		if Input.is_action_pressed("move_walk"):
			new_input.locomotion_actions.append("walk")
	
	if Input.is_action_pressed('move_jump'):
		if new_input.locomotion_actions.has("sprint"):
			new_input.locomotion_actions.append("jump_run") # TODO: handle sprint jump later
		elif new_input.locomotion_actions.has("walk"):
			new_input.locomotion_actions.append("jump_run") # TODO: handle walk jump later
		else: 
			new_input.locomotion_actions.append("jump_run")

	#TODO - move this to combat actions later on
	if Input.is_action_pressed('shoot'):
		new_input.locomotion_actions.append("shoot")
	
	return new_input
