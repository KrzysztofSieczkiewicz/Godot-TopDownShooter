@tool

class_name CustomSkeletonModifier
extends SkeletonModifier3D

@export var target_coordinate: Vector3 = Vector3.ZERO
@export_enum(" ") var bone: String

func _validate_property(property: Dictionary) -> void:
	pass

func _process_modification() -> void:
	pass
