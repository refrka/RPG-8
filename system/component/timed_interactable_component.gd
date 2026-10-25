class_name TimedInteractableComponent extends InteractableComponent


@export var interaction_duration:= 1.0


var interaction_timer:= 0.0





func _start() -> bool:

	interaction_timer = interaction_duration

	return false



func _complete() -> void:

	interaction_complete.emit()



func _cancel() -> void:

	interaction_timer = 0.0

	interaction_cancelled.emit()




func _process(delta: float) -> void:

	if !active or disabled:

		return

	if interaction_timer > 0.0:

		interaction_timer -= delta

		if interaction_timer <= 0.0:

			_complete()