extends Node3D

### Camera rays intersection
var ray_origin = Vector3()
var ray_projected = Vector3()
var ray_target = Vector3()

const ray_length = 2000
var ray_params = PhysicsRayQueryParameters3D.new()
var space_state
var viewport
var camera

func _ready():
	### Camera rays intersection
	viewport = get_viewport()
	space_state = get_world_3d().direct_space_state
	camera = $Camera3D

func _physics_process(delta):
	
	### Camera rays intersection
	var mouse_position = viewport.get_mouse_position()
	
	ray_origin = camera.project_ray_origin(mouse_position)
	ray_projected = camera.project_ray_normal(mouse_position) * ray_length
	ray_target = ray_origin + ray_projected
	
	ray_params.from = ray_origin
	ray_params.to = ray_target

	var intersection = space_state.intersect_ray(ray_params)
	
	if not intersection.is_empty():
		var intersection_pos = intersection.position
		var look_at_me = Vector3(intersection_pos.x, $Player.position.y ,intersection_pos.z)
		$Player.look_at(look_at_me, Vector3.UP)
