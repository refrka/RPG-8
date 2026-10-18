class_name PlayerHealthBar extends HealthProgressBar




func _ready() -> void:

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)




func _on_player_initialized(_event: Event) -> void:

	var player = Game.get_player()

	_initialize(player)