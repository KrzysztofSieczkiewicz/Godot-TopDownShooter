extends CharacterBody3D

class_name Enemy

var default_material = load("res://Enemy/EnemyDefaultMaterial.tres")
var attacking_material = load("res://Enemy/EnemyAttackingMaterial.tres")
var recovering_material = load("res://Enemy/EnemyRecoveringMaterial.tres")

@onready var nav_agent:NavigationAgent3D = $NavigationAgent3D
@onready var player:CharacterBody3D = $"../Player"
@onready var attack_timer:Timer = $AttackTimer

var movement_speed:float = 2.0
var attack_speed_multiplier:float = 7.0
var path = []

var attack_target:Vector3
var return_target:Vector3

enum state {
	SEEKING,
	ATTACKING,
	RETURNING,
	RECOVERING,
}
var current_state = state.SEEKING

func _ready():
	$MeshInstance3D.set_surface_override_material(0, default_material)
	
	nav_agent.path_desired_distance = 1
	nav_agent.target_desired_distance = 1

func _physics_process(delta):
	match current_state:
		state.SEEKING:
			actor_setup(player.global_transform.origin)
			if nav_agent.is_navigation_finished():
				return
			
			var current_agent_pos: Vector3 = global_position
			var next_agent_pos: Vector3 = nav_agent.get_next_path_position()
			velocity = current_agent_pos.direction_to(next_agent_pos) * movement_speed
			move_and_slide()
			
			var player_location = player.global_transform.origin
			var current_location = global_transform.origin
		
		state.ATTACKING:
			move_and_attack()
		
		state.RETURNING:
			move_and_attack()


func actor_setup(target_position:Vector3):
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	nav_agent.set_target_position(target_position)

func move_and_attack():
	var player_location = player.global_transform.origin
	var current_location = global_transform.origin
	var direction: Vector3 = attack_target - current_location
	velocity = direction.normalized() * movement_speed * attack_speed_multiplier
	move_and_slide()
	
	if direction.length() < 0.75:
		match current_state:
			state.ATTACKING:
				current_state = state.RETURNING
				attack_target = return_target
			state.RETURNING:
				$MeshInstance3D.set_surface_override_material(0, recovering_material)
				collide_with_other_enemies(true)
				current_state = state.RECOVERING
				attack_timer.start()
		
func collide_with_other_enemies(should_we_collide):
	set_collision_mask_value(2, should_we_collide)
	set_collision_layer_value(2, should_we_collide)

func _on_stats_you_died_signal():
	queue_free()

func _on_AttackTimer_timeout():
	current_state = state.SEEKING
	$MeshInstance3D.set_surface_override_material(0, default_material)

func _on_AttackRadius_body_entered(body):
	if body == player:
		return_target = global_transform.origin
		attack_target = player.global_transform.origin
		current_state = state.ATTACKING
		$MeshInstance3D.set_surface_override_material(0, attacking_material)
		collide_with_other_enemies(false)
