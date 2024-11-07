extends Node3D

@export var speed: int = 20
@export var damage: int = 1

const KILL_TIME_SECONDS = 2
var timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)
	
	timer += delta
	if timer > KILL_TIME_SECONDS:
		queue_free()

func _on_area_3d_body_entered(body:Node3D):
	queue_free()
	
	if body.has_node("Stats"):
		var stats_node: Stats = body.find_child("Stats")
		stats_node.take_hit(damage)
