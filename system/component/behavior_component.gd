class_name BehaviorComponent extends Component



signal behavior_changed


enum BehaviorState {

	PASSIVE,

	HOSTILE,

	FLEE,

	OVERRIDE,

}


var behavior_profile: BehaviorProfile

var behaviors: Array[Behavior]




var behavior_state: BehaviorState

var current_behavior: Behavior



var evaluation_timer:= 0.5

var change_cooldown:= 0.0




func _initialize(_entity: EntityNode) -> void:

	if disabled:

		return

	super(_entity)

	behavior_profile = entity.entity_def.behavior_profile.duplicate_deep()

	behaviors = behavior_profile.behaviors

	behaviors.append(behavior_profile.default_behavior)

	for behavior in behaviors:

		behavior._initialize(entity, self)

	_set_behavior_state(behavior_profile.default_behavior.required_behavior_state)





func _activate() -> void:

	if disabled:

		return

	super()

	_change_behavior(behavior_profile.default_behavior)




# Is the current behavior still valid? If not, choose a new one

func _evaluate() -> void:

	_update_behavior_state()

	var desired_target = _choose_target()

	var desired_behavior = _choose_behavior(behavior_state)

	if desired_behavior != current_behavior:

		_change_behavior(desired_behavior, desired_target)

	# Cases

	#	No change required

		#	a - Passive state, and there is no threat or hostile nearby

		#	b - Hostile state, and there is no better target than the current one

	#	Change required (target or behavior)

		#	a - Passive state, but hostile enemies are visible/near

		#	b - The current behavior's target is not the best target

		#	c - The current behavior has no valid target available

		#	d - The actor's condition has changed

	evaluation_timer = 1.0





func _update_behavior_state() -> void:

	if !_get_visible_hostile_entities().is_empty():

		_set_behavior_state(BehaviorState.HOSTILE)

	






func _change_behavior(behavior: Behavior, target: EntityNode = null) -> void:
	
	if !_can_change_behavior():

		return

	if behavior == current_behavior:

		return

	if current_behavior:

		current_behavior._stop()

	current_behavior = behavior

	behavior._start(target)

	change_cooldown = 2.0

	behavior_changed.emit()





func _choose_behavior(_behavior_state: BehaviorState) -> Behavior:

	var behavior_list = _get_state_behaviors(_behavior_state)

	behavior_list.sort_custom(func(b1, b2): return b1.priority > b2.priority)

	return behavior_list.front()





func _choose_target() -> EntityNode:

	match behavior_state:

		BehaviorState.HOSTILE:

			var hostile_targets = _get_visible_hostile_entities()

			if !hostile_targets.is_empty():

				var hostile_target = hostile_targets.front()

				return hostile_target

	return null




func _can_change_behavior() -> bool:

	return change_cooldown <= 0.0




func _set_behavior_state(_behavior_state: BehaviorState) -> void:

	behavior_state = _behavior_state




func _get_state_behaviors(_behavior_state: BehaviorState) -> Array[Behavior]:

	var state_behaviors: Array[Behavior] = behaviors.filter(func(b): return b.required_behavior_state == _behavior_state)

	state_behaviors.sort_custom(func(b1, b2): return b1.priority > b2.priority)

	return state_behaviors





func _get_hostility_score(target_entity: EntityNode) -> float:

	var score = 0.0

	if behavior_profile.baseline_hostility_scores.has(target_entity.entity_def):

		score = behavior_profile.baseline_hostility_scores[target_entity.entity_def]

	return score




func _get_visible_hostile_entities() -> Array[EntityNode]:

	var visible_entities = entity.vision_sensor.entities

	var visible_hostiles: Array[EntityNode] = []

	for entity_node in visible_entities:

		var hostility_score = _get_hostility_score(entity_node)

		if hostility_score > 0.0:

			visible_hostiles.append(entity_node)

	return visible_hostiles




func _physics_process(delta: float) -> void:

	if !active or disabled:

		return

	if current_behavior:

		current_behavior._tick(delta)

	if change_cooldown > 0.0:

		change_cooldown -= delta

	evaluation_timer -= delta

	if evaluation_timer <= 0.0:

		_evaluate()