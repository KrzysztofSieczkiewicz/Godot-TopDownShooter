class_name AnimationManager
extends Node

@onready var locomotion_animation_player = $LocomotionAnimator

func update_locomotion(current_moveset: ILocomotionSet,
		character_velocity: Vector3, 
		heading_basis: Basis):
	
	var local_velocity = heading_basis.inverse() * character_velocity
	var movement_angle = rad_to_deg(atan2(local_velocity.x, -local_velocity.z))
	
	var motion_data = current_moveset.get_motion_data(movement_angle)
	var blending_time = current_moveset.animation_blending_time
	
	_update_speed_scaling(character_velocity.length(), motion_data.speed)
	_play_synced(motion_data.animation_name, blending_time)

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
func calculate_mesh_rotation(
	movement_angle: float,  # angle between movement and looking directions
	animation_angle: float, # current animation angle from LocomotionSet
	current_rot: float,     # current mesh rotation
	delta: float) -> float:
	var angle_diff_deg = wrapf(movement_angle - animation_angle, -180, 180)
	var target_rad = deg_to_rad(angle_diff_deg)
	
	return lerp_angle(
		current_rot, 
		target_rad, 
		15.0 * delta # the "flexibility" value; higher is more responsive
	)

### TODO: go through this - maybe find a more flexible approach so animations doesn't need to match in length and stride
func _play_synced(anim_name: String, blending_time: float = 0):
	if locomotion_animation_player.current_animation == anim_name:
		return
	
	# Save the current animation progress (e.g., 0.4 seconds into the step)
	var current_pos = locomotion_animation_player.current_animation_position

	# rewind the new animation to the exact same spot so the feet can theoretically match
	# This assumes your walk/run/strafe clips are all the same length and start on the same foot
	locomotion_animation_player.play("Humanoid_normal/" + anim_name, 0.3)
	locomotion_animation_player.seek(current_pos)
