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

	player.show()

	var location = Scenes.load_location(active_save_data["location_id"])

	location.spawn_player(active_save_data["spawn_id"])

	location._activate()






func exit() -> void:

	active = false

	active_save_data = {}

	hold_player()

	Scenes.clear_location()

	Scenes.main_menu.show()





func quit() -> void:

	get_tree().quit()






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

	var data = get_save_template()

	file.store_string(JSON.stringify(data, " "))

	file.close()




func hold_player() -> void:

	if player.get_parent() == self:

		return

	player.hide()

	player.reparent(self)




func get_player() -> Player:

	if !player:

		player = load("res://system/player/player.tscn").instantiate()

		add_child(player)

		player._initialize()

	return player



func get_save_template() -> Dictionary:

	return load("res://system/misc/save_template.gd").new().data





func pause() -> void:

	get_tree().paused = true



func unpause() -> void:

	get_tree().paused = false









func is_paused() -> bool:

	return get_tree().paused