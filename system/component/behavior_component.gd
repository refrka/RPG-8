class_name BehaviorComponent extends Component



enum BehaviorState {

	IDLE,

	COMBAT,

	SURVIVAL,

}


var behavior_state: BehaviorState

var behaviors: Dictionary[BehaviorState, Array]


var current_behavior: Behavior




func _initialize(_entity: EntityNode) -> void:

	super(_entity)
	





func _change_behavior_state(new_state: BehaviorState) -> void:

	behavior_state = new_state

	var behavior_set = behaviors[new_state]




func _end_behavior_state() -> void:

	pass