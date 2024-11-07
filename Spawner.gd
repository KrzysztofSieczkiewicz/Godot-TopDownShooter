extends Node3D

@export var Enemy:PackedScene
@onready var timer:Timer = $Timer

var no_enemies_to_spawn:int
var no_curr_enemies_killed:int

var waves:Array
var current_wave:Wave
var current_wave_index:int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	waves = $Waves.get_children()
	start_next_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_next_wave():
	current_wave_index += 1
	no_curr_enemies_killed = 0
	
	if current_wave_index < waves.size():
		current_wave = waves[current_wave_index]
		no_enemies_to_spawn = current_wave.num_enemies
		timer.wait_time = current_wave.spawn_interval_seconds
		timer.start()


func connect_to_enemy_signals(enemy:Enemy):
	var stats = enemy.get_node("Stats")
	stats.you_died_signal.connect(_on_Enemy_Stats_you_died_signal)
	
func _on_Enemy_Stats_you_died_signal():
	no_curr_enemies_killed += 1

func _on_timer_timeout():
	if no_enemies_to_spawn:
		var enemy = Enemy.instantiate()
		connect_to_enemy_signals(enemy)
		var scene_root = get_parent()
		scene_root.add_child(enemy)
		no_enemies_to_spawn -= 1
	else:
		if no_curr_enemies_killed == current_wave.num_enemies:
			start_next_wave()
