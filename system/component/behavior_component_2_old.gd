class_name BehaviorComponent2Old extends Component




enum BehaviorState {

	NONE,

	PASSIVE,

	HOSTILE,

	TASK,

	OVERRIDE,

}



var behavior_list: Array[Behavior]

var current_behavior: Behavior

var current_behavior_state: BehaviorState

var current_behavior_target: EntityNode

var data:= {}



var evaluation_timer:= 0.5





func _initialize(_entity: EntityNode) -> void:

	if disabled:

		return
	
	super(_entity)

	if !entity.entity_def.behavior_profile:

		return

	behavior_list = entity.entity_def.behavior_profile.behaviors.duplicate_deep()

	for behavior in behavior_list:

		behavior._initialize(entity)




func _activate() -> void:

	if disabled:

		return

	super()

	_change_behavior_state(BehaviorState.PASSIVE)







func _evaluate() -> void:

	var valid_entities:= entity.vision_sensor.entities

	if current_behavior_target and !valid_entities.has(current_behavior_target):

		valid_entities.append(current_behavior_target)

	var behavior_profile:= get_behavior_profile()

	var greatest_score:= -INF

	var chosen_target: EntityNode = null

	for target_entity in valid_entities:

		var hostility_score = get_hostility_score(target_entity)

		if hostility_score >= behavior_profile.hostility_threshold:

				if !chosen_target or hostility_score > greatest_score:

					greatest_score = hostility_score

					chosen_target = target_entity

	match current_behavior_state:

		BehaviorState.PASSIVE:

			if chosen_target:

				print("hostile toward: ", chosen_target)

				_change_behavior_target(chosen_target)

				_change_behavior_state(BehaviorState.HOSTILE)

		BehaviorState.HOSTILE:

			if chosen_target != current_behavior_target:

				print("changing target to: ", chosen_target)

				_change_behavior_target(chosen_target)

	evaluation_timer = 0.5








func _update_behavior() -> void:

	var valid_behaviors = _get_behaviors_for_state(current_behavior_state)

	valid_behaviors.sort_custom(func(b1, b2): return b1.priority > b2.priority)

	if !valid_behaviors.is_empty():

		_change_behavior(valid_behaviors.front())

	






func _change_behavior(behavior: Behavior) -> void:

	if behavior == current_behavior:

		return

	if current_behavior:

		current_behavior._stop()

	current_behavior = behavior

	current_behavior._start(data)





func _change_behavior_state(behavior_state: BehaviorState) -> void:

	current_behavior_state = behavior_state

	_update_behavior()





func _change_behavior_target(target: EntityNode) -> void:

	current_behavior_target = target

	data["target"] = target

	if current_behavior:

		current_behavior._update_target(target)





func _get_behaviors_for_state(behavior_state: BehaviorState) -> Array:

	return behavior_list.filter(func(b): return b.behavior_state == behavior_state)




func _get_baseline_hostility_score(target: EntityNode) -> float:

	var behavior_profile = get_behavior_profile()

	if behavior_profile.baseline_hostility_scores.has(target.entity_def):

		return behavior_profile.baseline_hostility_scores[target.entity_def]

	return 0.0








func get_hostility_score(target: EntityNode) -> float:

	var score:= _get_baseline_hostility_score(target)

	if current_behavior:

		score = current_behavior._get_hostility_score(target, score)

	return score





func get_behavior_profile() -> BehaviorProfile:
	
	if not entity is CharacterNode:

		return null

	return entity.entity_def.behavior_profile






func _physics_process(delta: float) -> void:

	if !active or disabled:

		return

	if current_behavior:

		current_behavior._tick(delta)

	evaluation_timer -= delta

	if evaluation_timer <= 0.0:

		_evaluate()