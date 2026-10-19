class_name BehaviorOld2 extends Resource



@warning_ignore("unused_signal")

signal behavior_state_requested(behavior_state: BehaviorComponent2Old.BehaviorState)



@export var display_name: String

@export var behavior_state: BehaviorComponent2Old.BehaviorState

@export var priority:= 0


var active:= false

var actor: EntityNode

var data:= {}





func _initialize(_actor: EntityNode) -> void:

	actor = _actor





func _is_valid() -> bool:

	return true




func _is_target_valid(_target: EntityNode) -> bool:

	return true




func _start(_data:= {}) -> void:

	data = _data

	active = true

	_connect_signals()



func _stop() -> void:

	_disconnect_signals()

	active = false



func _connect_signals() -> void:

	pass


func _disconnect_signals() -> void:

	pass



func _interrupt() -> void:

	pass



func _update_target(target: EntityNode) -> void:

	var current_target = get_target()

	if current_target:

		current_target.died.disconnect(_on_target_died)

	data["target"] = target

	if is_instance_valid(target):

		target.died.connect(_on_target_died)





func _get_hostility_score(_target: EntityNode, score:= 0.0) -> float:

	return score





func get_target() -> EntityNode:

	if data.has("target"):

		return data.target
	
	return null




func _on_target_died() -> void:

	_update_target(null)





func _tick(_delta: float) -> void:

	pass