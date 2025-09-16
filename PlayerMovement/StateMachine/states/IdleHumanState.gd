class_name IdleHumanState

extends IState


func enter() -> void:
	animations.play("BasicMovement/Idle")

func update(delta: float):
	if parent.velocity.length() > 0.0 and parent.is_on_floor():
		transition.emit("WalkingHumanState")
