class_name Component extends Node






var active:= false

var entity: EntityNode



func _initialize(_entity: EntityNode) -> void:

	entity = _entity




func _activate() -> void:

	active = true

	_connect_signals()




func _deactivate() -> void:

	_disconnect_signals()

	active = false



func _clear() -> void:

	pass




func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass






func get_component_script() -> Script:

	return get_script()



func get_component_name() -> StringName:

	return name.trim_suffix("Component")