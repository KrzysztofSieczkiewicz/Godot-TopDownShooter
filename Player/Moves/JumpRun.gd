extends State 
class_name JumpRun



func _ready():
	animation = "BasicMovement/Running_Jump"

func check_is_relevant(input: InputPackage) -> String:
	return ""

func update(input: InputPackage, delta: float):
	pass
