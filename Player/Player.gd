extends CharacterBody3D


@onready var input_gatherer = $Input
@onready var player_model = $Model


func _physics_process(delta):
	var input = input_gatherer.get_current_input()
	velocity = player_model.velocity_by_input(input, delta)
	
	move_and_slide()
