class_name SprintingHumanState

extends IState


func enter() -> void:
	animations.play("BasicMovement/Sprinting")

func update(delta: float):
	if parent.velocity.length() == 0:
		transition.emit("IdleHumanState")
