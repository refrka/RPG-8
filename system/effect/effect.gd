class_name Effect extends Resource




@export var duration:= -1.0

@export var event_trigger: Script

var triggering_event: Event





func _initialize() -> void:

	if event_trigger:

		Events.subscribe(event_trigger, _on_event_trigger)





func _apply() -> void:

	pass





func _on_event_trigger(event: Event) -> void:

	triggering_event = event