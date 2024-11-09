extends Node
class_name State


var player : CharacterBody3D

# TODO: Consider moving this definition to the Input class - then make all states just return their action and
# the input will determine which action should be executed instead
static var moves_priority: Dictionary = {
	"idle": 1,
	"run": 2,
	"jump": 10
}

static func moves_priority_sort(a: String, b: String) -> bool:
	if moves_priority[a] > moves_priority[b]:
		return true
	return false


func check_is_relevant(input: InputPackage) -> String:
	var message = "ERROR: Implement the check_is_relevant function in Your state class"
	print_debug(message)
	return message


func update(input: InputPackage, delta: float):
	pass


func on_state_enter():
	pass


func on_state_exit():
	pass
