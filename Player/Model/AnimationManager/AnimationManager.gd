class_name AnimationManager
extends Node

@onready var locomotion_animation_player = $LocomotionAnimator
@onready var torso_animation_player = $TorsoAnimator

var _visual_pivot: Node3D


var _locomotion_buffer := ILocomotionSet.LocomotionResult.new() # Stores LocomotionSet data for current heading


func init(skeleton_pivot: Node3D):
	_visual_pivot = skeleton_pivot


func update_locomotion(
		moveset: ILocomotionSet,
		world_velocity: Vector3, 
		facing_basis: Basis,
		delta: float):
	
	var local_velocity = facing_basis.inverse() * world_velocity
	
	var current_move_angle = Vector2(local_velocity.x, local_velocity.z).angle()
	#var current_move_angle = Vector3.FORWARD.signed_angle_to(local_velocity, Vector3.UP)
	#var current_move_angle = atan2(-local_velocity.x, -local_velocity.z)
		
	moveset.update_motion_data(current_move_angle, _locomotion_buffer)
	#var compensation_angle_rad = wrapf(move_angle_rad - _locomotion_buffer.angle_rad, -PI, PI)
	
	var mesh_offset = wrapf(current_move_angle - _locomotion_buffer.angle_rad, -PI, PI)
		
	var new_rotation_rad = adjust_mesh_rotation(
		mesh_offset,
		_visual_pivot.rotation.y,
		10,
		delta)
	_visual_pivot.rotation.y = new_rotation_rad

	_update_speed_scaling(world_velocity.length(), _locomotion_buffer.speed)
	#_play_synced(_locomotion_buffer.animation_name, moveset.animation_blending_time)
	_play_synced("walking_f", moveset.animation_blending_time)


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
# TODO: organize the code around moving the mesh as skeleton children
func adjust_mesh_rotation(
	target_angle_rad: float,  # desired rotation
	current_rot_rad: float, # current mesh rotation
	flexibility_coeff: float,     # how responsive should the rotation be
	delta: float) -> float:
	
	return lerp_angle(
		current_rot_rad, 
		-target_angle_rad, # TODO: find a better place for this '-' sign
		flexibility_coeff * delta
	)

### TODO: go through this - maybe find a more flexible approach so animations doesn't need to match in length and stride
func _play_synced(anim_name: String, blending_time: float = 0):
	if locomotion_animation_player.current_animation == anim_name:
		return
	
	# Save the current animation progress (e.g., 0.4 seconds into the step)
	var current_pos = 0
	if locomotion_animation_player.current_animation:
		current_pos = locomotion_animation_player.current_animation_position

	# rewind the new animation to the exact same spot so the feet can theoretically match
	# This assumes your walk/run/strafe clips are all the same length and start on the same foot
	locomotion_animation_player.play("Humanoid_normal/" + anim_name, blending_time)
	locomotion_animation_player.seek(current_pos)
