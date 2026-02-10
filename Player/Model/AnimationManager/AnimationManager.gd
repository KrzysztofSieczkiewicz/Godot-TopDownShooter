class_name AnimationManager
extends Node

@onready var locomotion_animation_player = $LocomotionAnimator

var _visual_pivot: Node3D


func init(skeleton_pivot: Node3D):
	_visual_pivot = skeleton_pivot


func update_locomotion(
		moveset: ILocomotionSet,
		world_velocity: Vector3, 
		facing_basis: Basis,
		delta: float):
	
	var local_velocity = facing_basis.inverse() * world_velocity
	var move_angle_deg = rad_to_deg(atan2(local_velocity.x, -local_velocity.z))
	
	var motion_data = moveset.get_motion_data(move_angle_deg)
	var compensation_angle_deg = wrapf(move_angle_deg - motion_data.angle, -180, 180)
	
	var new_rotation_rad = adjust_mesh_rotation(
		compensation_angle_deg,
		_visual_pivot.rotation.y,
		15,
		delta)
	_visual_pivot.rotation.y = new_rotation_rad

	_update_speed_scaling(world_velocity.length(), motion_data.speed)
	_play_synced(motion_data.animation_name, moveset.animation_blending_time)


func _update_speed_scaling(char_speed: float, anim_move_speed: float):
	if anim_move_speed <= 0.001: 
		locomotion_animation_player.speed_scale = 1.0
		return
	
	var target_scale = char_speed / anim_move_speed
	
	locomotion_animation_player.speed_scale = move_toward(
		locomotion_animation_player.speed_scale, 
		target_scale, 
		0.05
	)


# TODO: work on this - most calculations overlap with update_locomotion
# TODO: fix rotation not applying
# TODO: fix the angle deg/rad - easier if standardized
# TODO: organize the code around moving the mesh as skeleton children
func adjust_mesh_rotation(
	target_angle_deg: float,  # desired rotation
	current_rot_rad: float, # current mesh rotation
	flexibility: float,     # how responsive should the rotation be
	delta: float) -> float:
	
	push_error(current_rot_rad)
	push_warning(deg_to_rad(target_angle_deg))
	
	return lerp_angle(
		current_rot_rad, 
		-deg_to_rad(target_angle_deg), # TODO: find a better place for this '-' sign
		flexibility * delta
	)

### TODO: go through this - maybe find a more flexible approach so animations doesn't need to match in length and stride
func _play_synced(anim_name: String, blending_time: float = 0):
	if locomotion_animation_player.current_animation == anim_name:
		return
	
	# Save the current animation progress (e.g., 0.4 seconds into the step)
	var current_pos = locomotion_animation_player.current_animation_position

	# rewind the new animation to the exact same spot so the feet can theoretically match
	# This assumes your walk/run/strafe clips are all the same length and start on the same foot
	locomotion_animation_player.play("Humanoid_normal/" + anim_name, blending_time)
	locomotion_animation_player.seek(current_pos)
