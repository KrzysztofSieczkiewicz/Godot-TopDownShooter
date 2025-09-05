extends Node3D

class_name PlayerModel

@onready var player_controller = $".."
@onready var skeleton = $HumanoidSkeleton as Skeleton3D
@onready var animator = $SkeletonAnimator as AnimationPlayer
