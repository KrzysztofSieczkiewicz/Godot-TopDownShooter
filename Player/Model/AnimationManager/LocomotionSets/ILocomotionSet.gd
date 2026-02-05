class_name ILocomotionSet 
extends Resource

@export_group("General")
## Intended base physical speed in current animation
@export var base_speed: float
@export var acceleration: float
@export var decceleration: float
## If set to false, player will use only the 0deg (forward) animation
@export var is_multidirectional: bool = true

@export var animation_blending_time: float

@export_group("Animations")
## Mapping of angle to animation name
## Example: { 0: "walk_f", 45: "walk_fr", 90: "walk_r" ... }
@export var animations: Dictionary[int, StringName] = {}

@export_group("Directional settings")
## Optional: Map of angles to specific speeds - allows to set speed in specific direction
## If empty, base_speed is used for all directions.
@export var directional_speeds: Dictionary[int, float] = {}


class LocomotionResult:
	var animation_name: StringName
	var angle: float
	var speed: float


func get_motion_data(move_angle_deg: float) -> LocomotionResult:
	var result = LocomotionResult.new()
	
	if not is_multidirectional or animations.size() <= 1:
		result.animation_name = animations.get(0, animations.values()[0] if animations.size() > 0 else "")
		result.angle = 0.0
		result.speed = base_speed
		return result
	
	var closest_angle = _get_closest_angle(move_angle_deg)
	
	result.animation_name = animations[closest_angle]
	result.angle = float(closest_angle)
	result.speed = directional_speeds.get(closest_angle, base_speed)
	return result


func _get_closest_angle(angle: float) -> int:
	var closest_angle: int = 0
	var min_diff: float = 360.0
	
	for animation_angle in animations.keys():
		var diff = abs(wrapf(angle - animation_angle, -180, 180))
		if diff < min_diff:
			min_diff = diff
			closest_angle = animation_angle
			
	return closest_angle
