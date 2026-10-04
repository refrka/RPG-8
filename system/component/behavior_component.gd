class_name BehaviorComponent extends Component



enum BehaviorState {

	PASSIVE,

	COMBAT,

	SURVIVAL,

}


var behavior_state: BehaviorState

var behaviors: Dictionary[BehaviorState, Array]


var current_behavior: Behavior

var behavior_data: Dictionary



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	behavior_data = {

		"actor": entity,

	}

	if !entity.entity_def.behavior_profile:

		return

	for behavior in entity.entity_def.behavior_profile.behaviors:

		if !behaviors.has(behavior.behavior_state):

			behaviors[behavior.behavior_state] = []

		behaviors[behavior.behavior_state].append(behavior.duplicate(true))






func _activate() -> void:

	super()

	_change_behavior_state(BehaviorState.PASSIVE)
	




func _connect_signals() -> void:

	entity.vision_area.body_entered.connect(_on_body_entered_vision_area)




func _disconnect_signals() -> void:

	entity.vision_area.body_entered.disconnect(_on_body_entered_vision_area)




func _change_behavior_state(new_state: BehaviorState) -> void:

	if !behaviors.has(new_state):

		return

	behavior_state = new_state

	var behavior_set = behaviors[new_state]

	var passed_behaviors = []

	for behavior in behavior_set:

		var passed = true

		for condition in behavior.conditions:

			if !condition._evaluate(behavior_data):

				passed = false
			
			if passed:

				passed_behaviors.append(behavior)

	var highest_priority:= 0

	var best_behavior: Behavior = null

	for behavior in passed_behaviors:

		if !best_behavior or behavior.priority > highest_priority:

			highest_priority = behavior.priority

			best_behavior = behavior

	if best_behavior:

		_change_behavior(best_behavior)




func _change_behavior(behavior: Behavior) -> void:

	if current_behavior:

		current_behavior._stop()

	current_behavior = behavior

	current_behavior._start()
		





func _on_body_entered_vision_area(body: PhysicsBody2D) -> void:

	if body == entity:

		return

	if body is Player:

		_change_behavior_state(BehaviorState.COMBAT)