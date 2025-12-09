class_name PlayerModel extends Node3D

@onready var player_controller = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
@onready var state_manager = $PlayerStateManager as PlayerStateManager


func _ready() -> void:
	state_manager.init(player_controller, animator);


func update(input: PlayerInput, delta: float) -> void:
	state_manager.update(input, delta)
