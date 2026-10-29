class_name Effect extends Resource


signal expired


@export var display_name: String

@export var duration:= -1.0

@export var event_trigger: Script

@export var animation: Animation

var entity: EntityNode

var triggering_event: Event

var _time_alive:= 0.0

var effect_animation_node: EffectAnimation





func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	if event_trigger:

		Events.subscribe(event_trigger, _on_event_trigger)






func is_expired() -> bool:

	if duration != -1.0:

		return _time_alive >= duration

	return false





func _apply() -> void:

	if animation:

		effect_animation_node = Scenes.add_effect_animation(entity, animation)





func _remove() -> void:

	if animation and effect_animation_node:
		
		entity.remove_child(effect_animation_node)
	




func _expire() -> void:

	expired.emit()




func _on_event_trigger(event: Event) -> void:

	triggering_event = event






func _tick(delta: float) -> void:

	_time_alive += delta