class_name ILocomotionSet 
extends Resource

@export_group("General")
## Intended base physical speed in current animation
@export var base_speed: float = 0.0
## If set to false, player will use only the forward animation
@export var is_multidirectional: bool

@export_group("Animations")
## Mapping of angle to animation name
## Example: { 0: "walk_f", 45: "walk_fr", 90: "walk_r" ... }
@export var animations: Dictionary[int, StringName] = {}

@export_group("Directional settings")
## Optional: Map of angles to specific speeds - allows to set speed in specific direction
## If empty, base_speed is used for all directions.
@export var directional_speeds: Dictionary[int, float] = {}

### TODO: change return type from Dictionary into class
func _get_motion_date(move_angle_deg: float) -> Dictionary:
	if not is_multidirectional or animations.size() <= 1:
		return {
			"name": animations.get(0, animations.values()[0] if animations.size() > 0 else ""), 
			"angle": 0.0, 
			"speed": base_speed
		}
	
	var closest_angle: int = 0
	var min_diff: float = 360.0
	
	for angle in animations.keys():
		var diff = abs(wrapf(move_angle_deg - angle, -180, 180))
		if diff < min_diff:
			min_diff = diff
			closest_angle = angle
	
	return {
		"name": animations[closest_angle],
		"angle": float(closest_angle),
		"speed": directional_speeds.get(closest_angle, base_speed)
	}
