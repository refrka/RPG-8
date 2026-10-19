class_name BehaviorComponentOld extends Component




enum BehaviorState {

	PASSIVE,

	TASK,

	HOSTILE,

	FLEE,

	RETURN_TO_ANCHOR,

}



@export var initial_state:= BehaviorState.PASSIVE



var behavior_state: BehaviorState

var behaviors: Array[BehaviorOld]

var current_behavior: BehaviorOld

var behavior_target: EntityNode

var target_last_known_position: Vector2

var data:= {}



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

	entity.vision_sensor.entity_entered.connect(_on_entity_entered_vision)






func _activate() -> void:

	if disabled:

		return

	super()

	_change_behavior_state(initial_state)






func _evaluate_and_choose_behavior(behavior_list: Array[BehaviorOld]) -> BehaviorOld:

	if behavior_list.is_empty():

		return null

	behavior_list.sort_custom(func(b1, b2): return b1.priority > b2.priority)

	return behavior_list.front()






func _change_behavior_state(new_state: BehaviorState) -> void:

	behavior_state = new_state

	var new_behavior: BehaviorOld = null

	if behavior_state == BehaviorState.RETURN_TO_ANCHOR:

		new_behavior = ReturnToAnchorBehavior.new()

		new_behavior._initialize(entity)

	else:

		var valid_behaviors = _get_valid_behaviors(new_state)

		new_behavior = _evaluate_and_choose_behavior(valid_behaviors)

	if new_behavior:

		_change_behavior(new_behavior)







func _change_behavior_target(new_target: EntityNode) -> void:
	
	behavior_target = new_target

	target_position_update_timer = 0.2

	if current_behavior:

		current_behavior._update_target(new_target)






func _change_behavior(behavior: BehaviorOld) -> void:

	var combat_component = entity.get_component(CombatComponent)

	if combat_component and combat_component.is_attacking():

		await combat_component.attack_completed

	if current_behavior:

		if current_behavior == behavior:

			return

		current_behavior._stop()

	current_behavior = behavior

	current_behavior._update_target(behavior_target)

	current_behavior._start(data)






func _update_target_position() -> void:

	if behavior_target != null:

		target_last_known_position = behavior_target.global_position

		if !is_target_valid(behavior_target):

			current_behavior._find_target()

		target_position_update_timer = 0.2







func _get_valid_behaviors(_behavior_state: BehaviorState) -> Array[BehaviorOld]:

	return behaviors.filter(func(b): return b.behavior_state == _behavior_state)







func request_behavior_state(_behavior_state: BehaviorState) -> void:

	_change_behavior_state(_behavior_state)












func is_target_valid(target_entity: EntityNode = null) -> bool:

	if !target_entity:

		target_entity = behavior_target

	if !is_target_in_range(target_entity):

		return false

	return true




func is_target_enemy(target: EntityNode = null) -> bool:

	if !target:

		if !behavior_target:

			return false

		target = behavior_target

	return entity.combat_melee_sensor.entities.has(target)

	



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





func _on_entity_entered_vision(entity_node: EntityNode) -> void:

	pass






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

	
