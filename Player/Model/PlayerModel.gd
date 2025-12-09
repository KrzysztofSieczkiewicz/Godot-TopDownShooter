class_name PlayerModel extends Node3D

@onready var player_controller = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
@onready var state_manager = $PlayerStateManager as PlayerStateManager

var current_move: IPlayerTorsoState
@onready var moves = {
	"idle": $PlayerStateManager/TorsoStateMachine/IdleState,
	"walk": $PlayerStateManager/TorsoStateMachine/WalkingState,
	"run": $PlayerStateManager/TorsoStateMachine/RunningState,
	"sprint": $PlayerStateManager/TorsoStateMachine/SprintingState,
	"weapon": $PlayerStateManager/TorsoStateMachine/WeaponState
}

func _ready() -> void:
	state_manager.init(player_controller, animator);
	
	current_move = moves["idle"]

func update(input: PlayerInput, delta: float) -> void:
	state_manager.update(input, delta)
