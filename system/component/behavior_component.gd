class_name BehaviorComponent extends Component




var default_behavior: Behavior

var combat_behavior: Behavior



var current_behavior: Behavior




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	default_behavior = entity.behavior_profile.default_behavior.duplicate(true)

	combat_behavior = entity.behavior_profile.combat_behavior.duplicate(true)

	