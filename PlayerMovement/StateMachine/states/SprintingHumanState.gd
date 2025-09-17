class_name SprintingHumanState

extends IState


func enter() -> void:
	animations.play("BasicMovement/Sprinting")

func update(delta: float):
	adjust_animation_speed(parent.velocity.length())
	if parent.velocity.length() == 0:
		transition.emit("IdleHumanState")
	elif parent.velocity.length() <= 6:
		transition.emit("WalkingHumanState")

func adjust_animation_speed(speed: float) -> void:
	var alpha = remap(speed, 0.0, parent.SPEED_SPRINTING, 0.0, 1.0)
	animations.speed_scale = lerp(0.0, 1.0, alpha)
