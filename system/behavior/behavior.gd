class_name Behavior extends Resource







var data:= {}

var actor: EntityNode




func _initialize(_actor: EntityNode) -> void:

	actor = _actor




func _start(_data:= {}) -> void:

	data = _data






func _stop() -> void:

	pass