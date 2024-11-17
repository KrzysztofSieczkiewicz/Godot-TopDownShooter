extends State
class_name Midair


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	animation = "BasicMovement/Running_Midair"


func check_transition(input: InputPackage) -> String:
	return "okay"

func update(input: InputPackage, delta: float):
	player.velocity.y -= gravity * delta
	player.move_and_slide()
