class_name HUD extends Overlay





func _ready() -> void:

	super()

	Events.subscribe(GameStartedEvent, _on_game_started)

	Events.subscribe(GameExitedEvent, _on_game_exited)



func _on_game_started(event: Event) -> void:

	show()



func _on_game_exited(event: Event) -> void:

	hide()