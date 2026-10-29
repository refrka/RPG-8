class_name Location extends Node2D



@export var ysort_root: Node2D

@export var feature_root: Node2D

@export var top_left_marker: Marker2D

@export var bottom_right_marker: Marker2D




var initialized:= false

var active:= false







func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	for entity in ysort_root.get_children():

		entity._initialize()

	for feature in feature_root.get_children():

		feature._initialize()

	return true




func _breakdown() -> void:

	_deactivate()
	
	initialized = false




func get_feature(feature_id: StringName) -> Feature:

	for feature in feature_root.get_children():

		if feature.feature_id == feature_id:

			return feature

	return null




func spawn_player(spawn_id: StringName, make_current:= false) -> void:

	var spawn_point = get_feature(spawn_id)

	if !spawn_point:

		return

	var player = Game.get_player()

	player.global_position = spawn_point.global_position

	if make_current:

		player.current_spawn_id = spawn_id

	player.reparent(ysort_root)

	player.show()

	Events.fire(PlayerSpawnedInLocationEvent, {"location": self, "spawn_id": spawn_id})





func drop_item(item_def: ItemDef, target_position: Vector2, count:= 1) -> void:

	var node = ItemNode.create_new(item_def, count)
	
	Scenes.current_location.add_entity_node(node, target_position)

	node._initialize()

	node._activate()







func add_entity_node(entity_node: EntityNode, target_position: Vector2) -> void:

	ysort_root.add_child.call_deferred(entity_node)

	entity_node.global_position = target_position

	entity_node._initialize()

	if active:

		entity_node._activate()




func _activate() -> void:

	await get_tree().physics_frame

	active = true

	for entity in ysort_root.get_children():

		entity._activate()

	for feature in feature_root.get_children():

		feature._activate()




func _deactivate() -> void:

	active = false

	for entity in ysort_root.get_children():

		entity._deactivate()

	for feature in feature_root.get_children():

		feature._deactivate()







func to_dict() -> Dictionary:

	var save_dict:= {}

	save_dict["entities"] = []

	for entity_node in ysort_root.get_children():

		if not entity_node.save_enabled or entity_node is Player:

			continue

		save_dict["entities"].append(entity_node._to_dict())

	return save_dict





func load_dict(save_dict: Dictionary) -> void:

	if save_dict.has("entities"):

		for entity_dict in save_dict["entities"]:

			var index = int(entity_dict["index"])

			if ysort_root.get_children().size() - 1 < index:

				var entity_id = entity_dict["entity_id"]

				var entity_node = Entities.get_entity_node(entity_id)

				var target_position = Vector2(entity_dict["global_position_x"], entity_dict["global_position_y"])

				add_entity_node(entity_node, target_position)

				ysort_root.move_child.call_deferred(entity_node, index)

				entity_node._load_dict(entity_dict)

			else:
			
				var entity_node = ysort_root.get_child(index)

				entity_node._load_dict(entity_dict)