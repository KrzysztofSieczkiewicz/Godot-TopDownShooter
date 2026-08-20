class_name PlayerModel extends Node3D

@onready var player_controller = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
@onready var state_manager = $PlayerStateManager as PlayerStateManager
@onready var animation_manager = $PlayerAnimationManager as AnimationManager

var CURRENT_MOVESET: ILocomotionLibrary = load("res://Player/Model/AnimationManager/LocomotionLibraries/normal.tres")


func _ready() -> void:
	state_manager.init(player_controller, animator);
	animation_manager.init(skeleton)

func update(input: PlayerInput, delta: float) -> void:
	state_manager.update(input, delta)
	
	# TODO: Implement proper gear logic
	var move = _get_move(HumanStates.LOCOMOTION_GEAR.SLOW)
	
	animation_manager.update_locomotion(
		move,
		player_controller.velocity,
		player_controller.global_basis,
		delta
	)
	
func _get_move(gear: HumanStates.LOCOMOTION_GEAR) -> ILocomotionSet:
	return CURRENT_MOVESET.move_sets[gear]
