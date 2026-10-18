class_name Anchor extends Feature


@export var anchor_range_limit:= 100.0




func anchor_entity(entity: EntityNode) -> void:

	var movement_component = entity.get_component(MovementComponent)

	movement_component.move_ended.connect(_on_entity_ended_move.bind(entity))

	var behavior_component = entity.get_component(BehaviorComponent)

	behavior_component.data["anchor"] = self




func _on_entity_ended_move(entity: EntityNode) -> void:

	var behavior_component = entity.get_component(BehaviorComponent)

	var distance = global_position.distance_to(entity.global_position)

	if distance >= anchor_range_limit:

		await Game.get_timer(1.0).timeout

		if is_instance_valid(entity):

			behavior_component.request_behavior_state(BehaviorComponent.BehaviorState.RETURN_TO_ANCHOR)

	else:

		if behavior_component.current_behavior is ReturnToAnchorBehavior:

			behavior_component.request_behavior_state(BehaviorComponent.BehaviorState.PASSIVE)