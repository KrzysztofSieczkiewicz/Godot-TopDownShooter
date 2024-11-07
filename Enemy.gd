extends CharacterBody3D

@onready var nav_agent:NavigationAgent3D = $NavigationAgent3D
@onready var player:CharacterBody3D = $"../Player"

var movement_speed:float = 2.0

var path = []

func _ready():
	nav_agent.path_desired_distance = 2.5
	nav_agent.target_desired_distance = 2.5

func _physics_process(delta):
	actor_setup(player.global_transform.origin)
	
	if nav_agent.is_navigation_finished():
		return
	
	var current_agent_pos: Vector3 = global_position
	var next_agent_pos: Vector3 = nav_agent.get_next_path_position()
	#print("Next position: ", next_agent_pos)
	
	velocity = current_agent_pos.direction_to(next_agent_pos) * movement_speed
	#print("Current velocity: ", velocity)
	move_and_slide()

func actor_setup(target_position:Vector3):
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	nav_agent.set_target_position(target_position)


func _on_stats_you_died_signal():
	queue_free()
