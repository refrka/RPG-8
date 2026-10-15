class_name BehaviorComponent extends Component



enum BehaviorState {

	PASSIVE,

	TASK,

	HOSTILE,

	FLEE,

}



@export var initial_state:= BehaviorState.PASSIVE



var behavior_state: BehaviorState

var behaviors: Array[Behavior]

var current_behavior: Behavior

var behavior_target: EntityNode

var target_last_known_position: Vector2





var target_position_update_timer:= 0.0




func _initialize(_entity: EntityNode) -> void:

	if disabled:

		return

	super(_entity)

	if !entity.entity_def.behavior_profile:

		return

	behaviors = entity.entity_def.behavior_profile.behaviors.duplicate_deep()

	for behavior in behaviors:

		behavior._initialize(entity)

		behavior.behavior_state_requested.connect(_on_behavior_state_requested)

		behavior.new_target_requested.connect(_on_new_target_requested)







func _activate() -> void:

	if disabled:

		return

	super()

	_change_behavior_state(initial_state)






func _evaluate_and_choose_behavior(behavior_list: Array[Behavior]) -> Behavior:

	if behavior_list.is_empty():

		return null

	behavior_list.sort_custom(func(b1, b2): return b1.priority > b2.priority)

	return behavior_list.front()






func _change_behavior_state(new_state: BehaviorState) -> void:

	var valid_behaviors = _get_valid_behaviors(new_state)

	var behavior = _evaluate_and_choose_behavior(valid_behaviors)

	if behavior:

		_change_behavior(behavior)







func _change_behavior_target(new_target: EntityNode) -> void:
	
	behavior_target = new_target

	current_behavior._update_target(new_target)






func _change_behavior(behavior: Behavior) -> void:

	if current_behavior:

		if current_behavior == behavior:

			return

		current_behavior._stop()

	current_behavior = behavior

	current_behavior._start()








func _update_target_position() -> void:

	if behavior_target != null:

		target_last_known_position = behavior_target.global_position

		if !is_target_valid(behavior_target):

			current_behavior._find_target()







func _get_valid_behaviors(_behavior_state: BehaviorState) -> Array[Behavior]:

	return behaviors.filter(func(b): return b.behavior_state == _behavior_state)







func is_target_valid(target_entity: EntityNode = null) -> bool:

	if !target_entity:

		target_entity = behavior_target

	if !is_target_in_range(target_entity):

		return false

	return true




func is_target_in_range(target_entity: EntityNode = null) -> bool:

	if !target_entity:

		target_entity = behavior_target

	var distance_sq = entity.global_position.distance_squared_to(target_entity.global_position)

	var threshold = entity.entity_def.behavior_profile.target_distance_threshold

	var threshold_sq = threshold * threshold

	if distance_sq <= threshold_sq:

		return true

	return false

	






func _on_behavior_state_requested(_behavior_state: BehaviorState) -> void:

	_change_behavior_state(_behavior_state)





func _on_new_target_requested(target_entity: EntityNode) -> void:

	_change_behavior_target(target_entity)






func _physics_process(delta: float) -> void:

	if disabled:

		return

	if behavior_target:

		if target_position_update_timer > 0.0:

			target_position_update_timer -= delta

			if target_position_update_timer <= 0.0:

				_update_target_position()

	if active and current_behavior:

		current_behavior._tick(delta)

	
