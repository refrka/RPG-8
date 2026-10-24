class_name PlayerHealthBar extends HealthProgressBar




func _ready() -> void:

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)

	Events.subscribe(PlayerSaveLoadedEvent, _on_player_save_loaded)




func _on_player_save_loaded(_event: Event) -> void:

	_load_health()



func _on_player_initialized(_event: Event) -> void:

	var player = Game.get_player()

	_initialize(player)
