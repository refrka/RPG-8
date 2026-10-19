class_name WolfCombatBehaviorOld extends BehaviorOld




var movement_component: MovementComponent



func _initialize(_actor: EntityNode) -> void:

	super(_actor)

	movement_component = actor.get_component(MovementComponent)




func _is_valid() -> bool:

	var target = get_target()

	return _is_target_valid(target)




func _is_target_valid(_target: EntityNode) -> bool:

	if !is_instance_valid(_target):

		return false

	return true











func _connect_signals() -> void:

	movement_component.navigation_position_reached.connect(_on_navigation_position_reached)


func _disconnect_signals() -> void:

	movement_component.navigation_position_reached.disconnect(_on_navigation_position_reached)



func _interrupt() -> void:

	pass




func _update_target(target: EntityNode) -> void:

	super(target)

	if !_is_target_valid(target):

		behavior_state_requested.emit(BehaviorComponent2.BehaviorState.PASSIVE)







func _get_hostility_score(_target: EntityNode, score:= 0.0) -> float:

	return score





func get_target() -> EntityNode:

	if data.has("target"):

		return data.target
	
	return null




func _on_target_died() -> void:

	_update_target(null)




func _on_navigation_position_reached() -> void:

	pass





func _tick(_delta: float) -> void:

	pass