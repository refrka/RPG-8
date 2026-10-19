class_name ReturnToAnchorBehavior extends BehaviorOld



var movement_component: MovementComponent




func _initialize(_actor: EntityNode) -> void:

	super(_actor)

	movement_component = actor.get_component(MovementComponent)






func _start(_data:= {}) -> void:

	super(_data)

	var anchor = data["anchor"]

	var dir = actor.global_position.direction_to(anchor.global_position)

	var distance = actor.global_position.distance_to(anchor.global_position)

	var target_position = actor.global_position + (dir * (distance - (anchor.anchor_range_limit / 2)))

	movement_component.navigation_position_reached.connect(_on_navigation_position_reached, CONNECT_ONE_SHOT)

	movement_component.set_navigation_position(target_position)




func _on_navigation_position_reached() -> void:

	pass