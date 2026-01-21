extends Node

var CURRENT_LOCOMOTION_MOVESETS: Dictionary[HumanStates.LOCOMOTION_GEAR, ILocomotionSet]
var CURRENT_ANIMATIONS: Dictionary[float, StringName]

func match_animation(velocity: Vector3):
	pass

func _get_matching_animation(velocity: Vector3):
	pass

func update_locomotion(current_moveset: ILocomotionSet, 
		velocity: float, 
		character_velocity: Vector3, 
		heading_basis: Basis, 
		delta: float):
	
	var local_velocity = heading_basis.inverse() * character_velocity
	var movement_angle = rad_to_deg(atan2(local_velocity.x, local_velocity.z))
	
	var motion_data = current_moveset.get_motion_data(movement_angle)
	
	## TODO: implement those
	#_apply_speed_scaling(world_velocity.length(), motion.speed)
	#_apply_rotation_offset(move_angle, motion.angle, delta)
	#_play_synced(motion.name)
