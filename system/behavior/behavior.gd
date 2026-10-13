class_name Behavior extends Resource



signal behavior_state_requested(state: BehaviorComponent.BehaviorState)





var data:= {}

var actor: EntityNode




func _initialize(_actor: EntityNode) -> void:

	actor = _actor




func _start(_data:= {}) -> void:

	data = _data

	_connect_signals()




func _stop() -> void:

	_disconnect_signals()



func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass




func _tick(_delta: float) -> void:

	pass