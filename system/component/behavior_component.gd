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

	super(_entity)

	behavior_profile = entity.entity_def.behavior_profile

	behaviors = behavior_profile.behaviors.duplicate_deep()

	behaviors.append(behavior_profile.default_behavior.duplicate())

	_set_behavior_state(behavior_profile.default_behavior.required_behavior_state)






func _activate() -> void:

	super()

	_change_behavior(behavior_profile.default_behavior)




# Is the current behavior still valid? If not, choose a new one

func _evaluate() -> void:

	# Cases

	#	No change required

		#	a - Passive state, and there is no threat or hostile nearby

		#	b - Hostile state, and there is no better target than the current one

	#	Change required (target or behavior)

		#	a - Passive state, but hostile enemies are visible/near

		#	b - The current behavior's target is not the best target

		#	c - The current behavior has no valid target available

		#	d - The actor's condition has changed

	match behavior_state:

		BehaviorState.PASSIVE:

			pass

		BehaviorState.HOSTILE:

			pass

	evaluation_timer = 1.0






func _change_behavior(behavior: Behavior, target: EntityNode = null) -> void:
	
	if !_can_change_behavior():

		return

	if current_behavior:

		current_behavior._stop()

	current_behavior = behavior

	behavior._start(target)

	change_cooldown = 2.0

	behavior_changed.emit()










func _can_change_behavior() -> bool:

	return change_cooldown <= 0.0




func _set_behavior_state(_behavior_state: BehaviorState) -> void:

	behavior_state = _behavior_state




func _get_state_behaviors(_behavior_state: BehaviorState) -> Array[Behavior]:

	return behaviors.filter(func(b): return b.required_behavior_state == _behavior_state)






func _physics_process(delta: float) -> void:

	if current_behavior:

		current_behavior._tick(delta)

	if change_cooldown > 0.0:

		change_cooldown -= delta

	evaluation_timer -= delta

	if evaluation_timer <= 0.0:

		_evaluate()