class_name Hurtbox extends Area2D


var active:= false

var invulnerable:= false

var entity: EntityNode





func _initialize(_entity: EntityNode) -> void:

	entity = _entity








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

