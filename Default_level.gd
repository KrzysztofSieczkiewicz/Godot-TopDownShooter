extends Node3D

signal mouse_world_intersection(intersection_data)

@onready var _camera = $CameraManager/Camera3D
var _ray_origin = Vector3()
var _ray_target = Vector3()

func _physics_process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	
	_ray_origin = _camera.project_ray_origin(mouse_position)
	_ray_target = _ray_origin + _camera.project_ray_normal(mouse_position) * 2000
	
	var space_state = get_world_3d().direct_space_state
	
	var ray_params = PhysicsRayQueryParameters3D.new()
	ray_params.from = _ray_origin
	ray_params.to = _ray_target
	var intersection = space_state.intersect_ray(ray_params)
	
	if not intersection.is_empty():
		emit_signal('mouse_world_intersection', intersection)
