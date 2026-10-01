extends Node





var subscriptions: Dictionary[Script, Array]






func subscribe(event_script: Script, callback: Callable) -> void:

	if !subscriptions.has(event_script):

		subscriptions[event_script] = []

	if !subscriptions[event_script].has(callback):

		subscriptions[event_script].append(callback)




func unsubscribe(event_script: Script, callback: Callable) -> void:

	pass





func fire(event: Event) -> void:

	var event_script = event.get_script()

	if subscriptions.has(event_script):

		for callback in subscriptions[event_script]:

			callback.call(event)