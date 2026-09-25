extends Node



var location_root: Node2D

var main_menu: MainMenu


var current_location: Location



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	location_root = get_tree().get_first_node_in_group("location_root")

	main_menu = get_tree().get_first_node_in_group("main_menu")












func load_location(location_id: StringName) -> Location:

	if current_location:

		clear_location()

	var location = get_location(location_id)

	if location:

		current_location = location

		location_root.add_child(current_location)

		location._initialize()

	return location




func clear_location() -> void:

	if !current_location:

		return

	current_location._breakdown()

	current_location.queue_free()

	current_location = null






func get_location(location_id: StringName) -> Location:

	var location_path = get_location_path(location_id)

	if FileAccess.file_exists(location_path):

		var location = load(location_path).instantiate()

		return location

	return null



func get_location_path(location_id: StringName) -> String:

	return "res://locations/%s.scn" % location_id