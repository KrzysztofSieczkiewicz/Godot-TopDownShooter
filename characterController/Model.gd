extends Node
class_name PlayerModel


@onready var player = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
@onready var states = {
	GlobalStates.HumanoidStates.IDLE: $States/Idle,
	GlobalStates.HumanoidStates.WALK: $States/Walk,
	GlobalStates.HumanoidStates.RUN: $States/Run,
	GlobalStates.HumanoidStates.IDLE_JUMP: $States/JumpIdle,
	#GlobalStates.HumanoidStates.WALK_JUMP: $States/JumpWalk,
	GlobalStates.HumanoidStates.RUN_JUMP: $States/JumpRun,
	#"jump_walk": $States/JumpWalk
	#GlobalStates.HumanoidStates.RUN_JUMP: $States/JumpRun,
	#"landing": "",
	#"landing_run": "",
	#"landing_sprint": "" 
	GlobalStates.HumanoidStates.MIDAIR: $States/Midair,
}

var current_move: IState


func _ready():
	current_move = states[GlobalStates.HumanoidStates.IDLE]
	
	for state in states.values():
		state.player = player

func update(input: InputPackage, delta: float):
	var relevant = current_move.check_transition(input)
	if relevant != GlobalStates.HumanoidStates.ONGOING:
		switch_to(relevant)
	current_move.update(input, delta)

func switch_to(state: GlobalStates.HumanoidStates):
	current_move.on_state_exit()
	current_move = states[state]
	current_move.on_state_enter()
	current_move.mark_state_entered()
	animator.play(current_move.animation)
