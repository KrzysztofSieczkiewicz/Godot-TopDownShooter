extends Node
class_name PlayerModel


@onready var player = $".."
@onready var states = {
	"idle": $Idle,
	"run": $Run,
	"jump": $Jump
}

var current_move: State


func _ready():
	current_move = states["idle"]
	
	for move in states.values():
		move.player = player

func update(input: InputPackage, delta: float):
	var relevant = current_move.check_is_relevant(input)
	if relevant != "okay":
		switch_to(relevant)
	
	current_move.update(input, delta)

func switch_to(state: String):
	current_move.on_state_exit()
	current_move = states[state]
	current_move.on_state_enter()
