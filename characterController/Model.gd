extends Node
class_name PlayerModel


@onready var player = $".."
@onready var skeleton = $GeneralSkeleton
@onready var animator = $SkeletonAnimator
@onready var states = {
	"idle": $Idle,
	"run": $Run,
	"sprint": $Sprint,
	"jump": $Jump
}

var current_move: State


func _ready():
	animator.get_animation("mixamo_com").loop_mode = Animation.LOOP_LINEAR
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
	animator.play(current_move.animation)
