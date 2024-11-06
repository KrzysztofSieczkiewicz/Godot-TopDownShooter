extends Node3D

@export var Bullet: PackedScene

@onready var rof_timer = $Timer
var can_shoot = true

@export var MuzzleVelocity: int = 30
@export var ShootingIntervalSecond: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	rof_timer.wait_time = ShootingIntervalSecond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	if can_shoot:
		var new_bullet = Bullet.instantiate()
		new_bullet.global_transform = $Muzzle.global_transform
		new_bullet.speed = MuzzleVelocity
		get_tree().current_scene.add_child(new_bullet)
		can_shoot = false
		rof_timer.start()

func _on_timer_timeout():
	can_shoot = true
