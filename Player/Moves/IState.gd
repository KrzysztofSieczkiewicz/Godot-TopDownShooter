extends Node
class_name IState


var player: CharacterBody3D

var animation: String
var has_animation_ended: bool

var state_entered_time: float


# TODO: Consider moving this definition to the Input class - then make all states just return their action and
# the input will determine which action should be executed instead
static var moves_priority: Dictionary = {
	GlobalStates.HumanoidStates.IDLE: 1,
	GlobalStates.HumanoidStates.WALK: 2,
	GlobalStates.HumanoidStates.RUN: 3,
	#"jump_idle": 10,
	#"jump_walk": 10,
	#"jump_run": 10,
	#"landing_idle": 10,
	#"landing_run": 10,
	#"midair": 10,
}


static func moves_priority_sort(a: String, b: String) -> bool:
	return moves_priority[a] > moves_priority[b]


func check_transition(input: InputPackage) -> GlobalStates.HumanoidStates:
	var message = "ERROR: Implement the check_transition function in Your state class"
	print_debug(message)
	return GlobalStates.HumanoidStates.IDLE


func update(input: InputPackage, delta: float):
	pass


func on_state_enter():
	pass


func on_state_exit():
	pass


func mark_state_entered():
	state_entered_time = Time.get_unix_time_from_system()


func get_state_progress() -> float:
	return Time.get_unix_time_from_system() - state_entered_time


func works_longer_than(time: float) -> bool:
	return get_state_progress() >= time


func works_less_than(time: float) -> bool:
	return get_state_progress() < time 


func works_in_time_range(start: float, finish: float) -> bool:
	var progress = get_state_progress()
	return progress >= start and progress <= finish
