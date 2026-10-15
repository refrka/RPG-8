class_name Behavior extends Resource



signal behavior_state_requested(state: BehaviorComponent.BehaviorState)

signal new_target_requested(new_target: EntityNode)




@export var priority:= 0

@export var behavior_state: BehaviorComponent.BehaviorState

@export var target_position_update_time:= 0.2


var data:= {}

var actor: EntityNode

var target: EntityNode





func _initialize(_actor: EntityNode) -> void:

	actor = _actor






func _start(_data:= {}) -> void:

	data = _data

	_connect_signals()






func _stop() -> void:

	_disconnect_signals()





func _find_target() -> void:

	pass






func _update_target(new_target: EntityNode) -> void:

	target = new_target






func _connect_signals() -> void:

	pass





func _disconnect_signals() -> void:

	pass

