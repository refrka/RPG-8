extends Node





var subscriptions: Dictionary[Script, Array]

var type_subscriptions: Dictionary[Script, Array]





func subscribe(event_script: Script, callback: Callable) -> void:

	if !subscriptions.has(event_script):

		subscriptions[event_script] = []

	if !subscriptions[event_script].has(callback):

		subscriptions[event_script].append(callback)



func subscribe_type(event_script: Script, callback: Callable) -> void:

	if !type_subscriptions.has(event_script):

		type_subscriptions[event_script] = []

	if !type_subscriptions[event_script].has(callback):

		type_subscriptions[event_script].append(callback)





func unsubscribe(event_script: Script, callback: Callable) -> void:

	pass





func fire(event_script: Script, data:= {}) -> void:

	var event = event_script.new()

	event.data = data

	if subscriptions.has(event_script):

		for callback in subscriptions[event_script]:

			callback.call(event)

