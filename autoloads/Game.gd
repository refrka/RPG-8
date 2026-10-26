extends Node




var player: Player

var active:= false

var active_save_data: Dictionary

var save_path:= "user://save_1.json"








func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS




func start() -> void:

	load_save()

	Scenes.main_menu.hide()

	active = true

	get_player()

	player.load_save_data(active_save_data)

	player.show()

	var location = Scenes.load_location(active_save_data["location_id"])

	location.spawn_player(active_save_data["spawn_id"])

	location._activate()

	Events.fire(GameStartedEvent)







func exit() -> void:

	active = false

	active_save_data = {}

	hold_player()

	player.load_template()

	Scenes.clear_location()

	Scenes.main_menu.show()

	Events.fire(GameExitedEvent)





func quit() -> void:

	get_tree().quit()


 



func save() -> void:

	var save_data = _get_save_data()

	save_data["fresh_save"] = false

	active_save_data = save_data

	var file = FileAccess.open(save_path, FileAccess.WRITE)

	file.store_string(JSON.stringify(save_data, " "))

	file.close()






func load_save() -> void:

	if !FileAccess.file_exists(save_path):

		create_new_save()

	var file = FileAccess.open(save_path, FileAccess.READ)

	var json = JSON.new()

	json.parse(file.get_as_text())

	file.close()

	active_save_data = json.data





func create_new_save() -> void:

	var file = FileAccess.open(save_path, FileAccess.WRITE)

	get_player()

	var data = player.load_template()

	file.store_string(JSON.stringify(data, " "))

	file.close()




func hold_player() -> void:

	if player.get_parent() == self:

		return

	player._deactivate()

	player.hide()

	player.reparent(self)




func get_player() -> Player:

	if !player:

		player = load("res://system/player/player.tscn").instantiate()

		add_child(player)

		player.hide()

		player._initialize()

	return player



func get_save_template() -> Dictionary:

	return load("res://system/misc/save_template.gd").new().data



func get_timer(duration: float) -> SceneTreeTimer:

	var timer = get_tree().create_timer(duration)

	return timer




func pause() -> void:

	get_tree().paused = true



func unpause() -> void:

	get_tree().paused = false







func is_paused() -> bool:

	return get_tree().paused






func _get_save_data() -> Dictionary:

	var save_data = player.get_save_data()

	return save_data