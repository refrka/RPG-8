class_name State extends Node


signal transition_requested(state_script: Script)



@export var allow_reenter:= false

var active:= false

var entity: EntityNode





func _initialize(_entity: EntityNode) -> void:

	entity = _entity



func _enter() -> void:

	active = true

	_connect_signals()



func _exit() -> void:

	_disconnect_signals()

	active = false



func _tick(_delta: float) -> void:

	pass



func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass









func get_state_name() -> String:

	return name.trim_suffix("State")



func get_state_script() -> Script:

	return get_script()