extends Node
class_name PlayerModel


@onready var player = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
@onready var states = {
	"idle": $States/Idle,
	"walk": $States/Walk,
	"run": $States/Run,
	"jump_idle": $States/JumpIdle,
	#"jump_walk": $States/JumpWalk
	"jump_run": $States/JumpRun,
	#"landing": "",
	#"landing_run": "",
	#"landing_sprint": "" 
	"midair": $States/Midair,
}

var current_move: IState


func _ready():
	animator.get_animation("BasicMovement/Idle").loop_mode = Animation.LOOP_LINEAR
	current_move = states["idle"]
	
	for state in states.values():
		state.player = player

func update(input: InputPackage, delta: float):
	var relevant = current_move.check_transition(input)
	if relevant != "okay":
		switch_to(relevant)
	current_move.update(input, delta)

func switch_to(state: String):
	current_move.on_state_exit()
	current_move = states[state]
	current_move.on_state_enter()
	current_move.mark_state_entered()
	animator.play(current_move.animation)
