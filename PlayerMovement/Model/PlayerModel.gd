class_name PlayerModel extends Node3D

@onready var player_controller = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
@onready var state_manager = $PlayerStateManager as PlayerStateManager

var current_move: IPlayerActionState
@onready var moves = {
	"idle": $PlayerStateManager/ActionStateMachine/IdleState,
	"walk": $PlayerStateManager/ActionStateMachine/WalkingState,
	"run": $PlayerStateManager/ActionStateMachine/RunningState,
	"sprint": $PlayerStateManager/ActionStateMachine/SprintingState,
	"shoot": $PlayerStateManager/ActionStateMachine/ShootingState
}

func _ready() -> void:
	state_manager.init(player_controller, animator); # Initialize state machine with player and animator reference TODO: drop animator reference
	
	current_move = moves["idle"]

func update(input: PlayerInput, delta: float) -> void:
	pass
