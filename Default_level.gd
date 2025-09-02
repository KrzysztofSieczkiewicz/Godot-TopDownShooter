extends Node3D

signal mouse_world_intersection(intersection_data)

@onready var camera = $CameraManager/Camera3D
var ray_origin = Vector3()
var ray_target = Vector3()

func _physics_process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	
	ray_origin = camera.project_ray_origin(mouse_position)
	ray_target = ray_origin + camera.project_ray_normal(mouse_position) * 2000
	
	var space_state = get_world_3d().direct_space_state
	
	var ray_params = PhysicsRayQueryParameters3D.new()
	ray_params.from = ray_origin
	ray_params.to = ray_target
	var intersection = space_state.intersect_ray(ray_params)
	
	if not intersection.is_empty():
		emit_signal('mouse_world_intersection', intersection)
