extends Node3D

@export var StartingWeapon: PackedScene
var hand: Marker3D
var equipped_weapon: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	hand = get_parent().find_child("Hand")
	
	if StartingWeapon:
		equip_weapon(StartingWeapon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func equip_weapon(weapon_to_equip):
	if equipped_weapon:
		print("replacing current weapon")
		equipped_weapon.queue_free()
	else:
		print("equipping weapon")
		equipped_weapon = weapon_to_equip.instantiate()
		hand.add_child(equipped_weapon)
	
func shoot():
	if equipped_weapon:
		equipped_weapon.shoot()
