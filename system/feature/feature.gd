class_name Feature extends Node2D


@export var feature_id: StringName



var active:= false










func _initialize() -> void:

	pass






func _activate() -> void:

	active = true

	_connect_signals()




func _deactivate() -> void:

	_disconnect_signals()

	active = false




func _connect_signals() -> void:

	pass




func _disconnect_signals() -> void:

	pass