class_name Effect extends Resource


signal expired


@export var duration:= -1.0

@export var event_trigger: Script

var entity: EntityNode

var triggering_event: Event

var _time_alive:= 0.0





func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	if event_trigger:

		Events.subscribe(event_trigger, _on_event_trigger)






func is_expired() -> bool:

	if duration != -1.0:

		return _time_alive >= duration

	return false





func _apply() -> void:

	pass
	


func _expire() -> void:

	expired.emit()




func _on_event_trigger(event: Event) -> void:

	triggering_event = event






func _tick(delta: float) -> void:

	_time_alive += delta