extends Node3D
class_name PlayerVisuals

@onready var beta_joints = $Beta_Joints
@onready var beta_surface = $Beta_Surface


func accept_skeleton(skeleton: Skeleton3D):
	beta_surface.skeleton = skeleton.get_path()
	beta_joints.skeleton = skeleton.get_path()
