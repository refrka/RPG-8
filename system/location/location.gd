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




func spawn_player(spawn_id: StringName) -> void:

	var spawn_point = get_feature(spawn_id)

	if !spawn_point:

		return

	var player = Game.get_player()

	player.reparent(ysort_root)

	player.global_position = spawn_point.global_position







func _activate() -> void:

	active = true

	_connect_signals()

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