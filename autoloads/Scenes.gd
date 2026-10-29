extends Node




@onready var effect_animation_node_scene:= preload("res://system/effect/effect_animation.tscn")


var location_root: Node2D

var main_menu: MainMenu


var current_location: Location



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	location_root = get_tree().get_first_node_in_group("location_root")

	main_menu = get_tree().get_first_node_in_group("main_menu")







func load_location(location_id: StringName) -> Location:

	if current_location:

		var location_dict = current_location.to_dict()

		Game.active_save_data["locations"][get_location_id()] = location_dict

		clear_location()

	var location = get_location(location_id)

	if location:

		if Game.active_save_data["locations"].has(location_id):

			location.load_dict(Game.active_save_data["locations"][location_id])

		current_location = location

		location_root.add_child(current_location)

		location._initialize()

	return location





func transition_to(location_id: StringName, spawn_id: StringName) -> void:

	Game.hold_player()

	var location = load_location(location_id)

	location.spawn_player(spawn_id)

	location._activate()





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




func get_location_id() -> StringName:

	return current_location.scene_file_path.trim_prefix("res://locations/").trim_suffix(".scn")




func get_location_save_data() -> Dictionary:

	var location_dict = Game.active_save_data["locations"].duplicate()

	if current_location:

		var location_id = get_location_id()

		if not location_dict.has(location_id):

			location_dict[location_id] = {}

		location_dict[location_id] = current_location.to_dict()

	return location_dict




func add_effect_animation(entity: EntityNode, effect_animation: Animation) -> EffectAnimation:

	var effect_animation_node = effect_animation_node_scene.instantiate() as EffectAnimation

	entity.add_child(effect_animation_node)

	effect_animation_node.anim_player.get_animation_library("").add_animation(effect_animation.resource_name, effect_animation)

	effect_animation_node.anim_player.play(effect_animation.resource_name)

	return effect_animation_node
