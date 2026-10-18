class_name Behavior extends Resource



@warning_ignore_start("unused_signal")

signal behavior_state_requested(state: BehaviorComponent.BehaviorState)

signal new_target_requested(new_target: EntityNode)





@export var priority:= 0

@export var behavior_state: BehaviorComponent.BehaviorState

@export var target_position_update_time:= 0.2

var active:= false

var data:= {}

var actor: EntityNode

var target: EntityNode





func _initialize(_actor: EntityNode) -> void:

	actor = _actor






func _start(_data:= {}) -> void:

	data = _data

	active = true

	_connect_signals()






func _stop() -> void:

	active = false

	_disconnect_signals()





func _find_target() -> void:

	pass




func _evaluate_target(_target: EntityNode = null) -> bool:

	if !_target:

		_target = target
	
	if !is_instance_valid(_target):

		return false

	return true






func _update_target(new_target: EntityNode) -> void:

	if target and new_target == target:

		return

	if _evaluate_target(new_target):

		if target:

			target.died.disconnect(_on_target_died)

		target = new_target

		target.died.connect(_on_target_died)






func _connect_signals() -> void:

	pass





func _disconnect_signals() -> void:

	pass



func _on_target_died() -> void:

	pass



func _tick(_delta: float) -> void:

	pass