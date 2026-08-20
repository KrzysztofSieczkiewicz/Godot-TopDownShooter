@tool
class_name ILocomotionSet 
extends Resource


class LocomotionResult:
	var animation_name: StringName
	var angle_rad: float
	var speed: float


@export_group("General")
@export var base_speed: float ## Intended base physical speed in current animation
@export var acceleration: float
@export var decceleration: float
@export var is_multidirectional: bool = true ## If set to false, player will use only the 0deg (forward) animation
@export var animation_blending_time: float

@export_group("Animations")
@export var animations: Dictionary[int, StringName] = {}: ## Mapping of angle to animation name
	set(value):
		animations = value
		_bake_all_angles_in_radians()
		notify_property_list_changed()
		
@export var directional_speeds: Dictionary[int, float] = {}: ## Optional: Mapping of angles to specific speeds
	set(value):
		directional_speeds = value
		_bake_all_angles_in_radians()
		notify_property_list_changed()

@export_storage var _baked_radians: PackedFloat32Array = []
@export_storage var _baked_names: Array[StringName] = []
@export_storage var _baked_speeds: PackedFloat32Array = []


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = PackedStringArray()
	
	if animations.is_empty():
		warnings.append("Animation dictionary has no assigned animation")
	
	for speed_deg in directional_speeds: # Check for speeds without animations
		if not animations.has(speed_deg):
			warnings.append("Orphaned Speed: %d° has a speed defined but no corresponding animation." % speed_deg)
	
	if is_multidirectional: # Check for animations without speeds (if multidirectional)
		for anim_deg in animations:
			if not directional_speeds.has(anim_deg):
				warnings.append("Missing Speed: %d° has an animation but no directional speed override." % anim_deg)
	
	return warnings


func _bake_all_angles_in_radians():
	_baked_radians.clear()
	_baked_names.clear()
	_baked_speeds.clear()
	
	if not is_multidirectional: # Handle single directional locomotion
		var key = 0 if animations.has(0) else animations.keys()[0]
		_baked_radians.append(0.0)
		_baked_names.append(animations[key])
		_baked_speeds.append(directional_speeds.get(key, base_speed))
		return
	else: # Handle multi directional locomotion
		var sorted_degs = animations.keys()
		sorted_degs.sort()
		
		for deg in sorted_degs:
			var rad = deg_to_rad(deg) # Resource 90deg (Counter-Clockwise) = -1.57rad (Counter-Clockwise)
			_baked_radians.append(rad)
			_baked_names.append(animations[deg])
			_baked_speeds.append(directional_speeds.get(deg, base_speed))


func _init(): # Safety check
	if _baked_names.is_empty() and not animations.is_empty():
		_bake_all_angles_in_radians()

func update_motion_data(angle_rad: float, out_result: LocomotionResult) -> void:
	
	var closest_idx = _get_closest_index(angle_rad)
		
	out_result.animation_name = _baked_names[closest_idx]
	out_result.angle_rad = _baked_radians[closest_idx]
	out_result.speed = _baked_speeds[closest_idx]


func _get_closest_index(target_rad: float) -> int:
	
	var closest_index: int = 0
	var min_diff: float = INF
	var count = _baked_radians.size()
	
	for i in range(count):
		var diff = abs(wrapf(target_rad - _baked_radians[i], -PI, PI))
		
		if diff < min_diff:
			min_diff = diff
			closest_index = i
	
	return closest_index
