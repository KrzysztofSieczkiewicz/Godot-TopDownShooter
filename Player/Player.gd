extends CharacterBody3D

@onready var input_handler = $Input as InputHandler
@onready var model = $Model as PlayerModel
@onready var visuals = $Visuals as PlayerVisuals

func _ready():
	visuals.accept_skeleton(model.skeleton)
	model.animator.play("BasicMovement/Idle")

func _physics_process(delta):
	var input = input_handler.get_current_input()
	model.update(input, delta)
	
	move_and_slide()
