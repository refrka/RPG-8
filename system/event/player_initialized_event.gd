class_name PlayerInitializedEvent extends GameEvent




static func fire(_data:= {}) -> void:

	var event = PlayerInitializedEvent.new()

	event.data = _data

	Events.fire(event)