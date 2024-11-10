extends State
class_name NewState

# Step 1:  Rename class_name
# Step 2:  Provide proper animation name in the 'animation' variable
# Step 3:  Implement proper check_is_relevant check
# Step 4:  Implement proper update function


func _ready():
	animation = "animationName"


func check_is_relevant(input: InputPackage) -> String:
	return ""


func update(input: InputPackage, delta: float):
	pass
