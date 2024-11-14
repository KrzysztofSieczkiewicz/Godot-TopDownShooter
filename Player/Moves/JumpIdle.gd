extends State
class_name IdleJump

const TRANSITION_TIME = 0.5
const JUMP_TIMING = 0.1

var jumped: bool = false


func _ready():
	animation = "BasicMovement/Idle_Jump"


func _check_is_relevant(input: InputPackage):
	return "okay"


#func update(input: InputPackage, delta: float):
