extends CharacterBody3D


@onready var input_gatherer = $Input as InputGatherer
@onready var model = $Model as PlayerModel
@onready var visuals = $Visuals as PlayerVisuals

func _ready():
	visuals.accept_skeleton(model.skeleton)
	#model.animator.play("BasicMovement/Idle")

func _physics_process(delta):
	var input = input_gatherer.get_current_input()
	model.update(input, delta)
	
	move_and_slide()
