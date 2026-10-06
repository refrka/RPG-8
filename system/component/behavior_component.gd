class_name BehaviorComponent extends Component



enum BehaviorState {

	PASSIVE,

	HOSTILE,

	DEFENSIVE,

}



@export var initial_state: BehaviorState

var behavior_state: BehaviorState

var behaviors: Dictionary[BehaviorState, Behavior]

var current_behavior: Behavior




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	if !entity.entity_def.behavior_profile:

		return

	behaviors = entity.entity_def.behavior_profile.behaviors.duplicate(true)







func _activate() -> void:

	super()

	_change_behavior_state(initial_state)







func _change_behavior_state(new_state: BehaviorState) -> void:

	var behavior = _get_behavior(new_state)

	if behavior:

		_change_behavior(behavior)




func _change_behavior(behavior: Behavior) -> void:

	if current_behavior:

		current_behavior._stop()

	current_behavior = behavior

	current_behavior._start()







func _get_behavior(_behavior_state: BehaviorState) -> Behavior:

	if behaviors.has(_behavior_state):

		return behaviors[_behavior_state]

	return null







func _physics_process(delta: float) -> void:

	if active and current_behavior:

		current_behavior._tick(delta)