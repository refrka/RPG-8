class_name GameCamera extends Camera2D





func _ready() -> void:

	Events.subscribe(PlayerSpawnedInLocationEvent, _on_player_spawned_in_location)

	Events.subscribe(PlayerDyingEvent, _on_player_dying)





func _on_player_spawned_in_location(event: Event) -> void:

	var player = Game.get_player()

	reparent(player)

	var location = event.data["location"]

	limit_left = location.top_left_marker.global_position.x

	limit_top = location.top_left_marker.global_position.y

	limit_bottom = location.bottom_right_marker.global_position.y

	limit_right = location.bottom_right_marker.global_position.x

	position = Vector2.ZERO



func _on_player_dying(event: Event) -> void:

	var game_root = get_tree().get_first_node_in_group("game_root")

	reparent(game_root)