class_name Location extends Node2D



@export var ysort_root: Node2D

@export var feature_root: Node2D


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





func drop_item(item_def: ItemDef, target_position: Vector2, count:= 1) -> void:

	var node = ItemNode.create_new(item_def, count)
	
	Scenes.current_location.add_entity_node(node, target_position)







func add_entity_node(entity_node: EntityNode, target_position: Vector2) -> void:

	ysort_root.add_child.call_deferred(entity_node)

	entity_node.global_position = target_position




func _activate() -> void:

	await get_tree().physics_frame

	_connect_signals()

	active = true

	for entity in ysort_root.get_children():

		entity._activate()

	for feature in feature_root.get_children():

		feature._activate()




func _deactivate() -> void:

	_disconnect_signals()

	active = false

	for entity in ysort_root.get_children():

		entity._deactivate()

	for feature in feature_root.get_children():

		feature._deactivate()

















func _connect_signals() -> void:

	pass




func _disconnect_signals() -> void:

	pass