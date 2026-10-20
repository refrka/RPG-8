class_name Behavior extends Resource



@export var display_name: String

@export var required_behavior_state: BehaviorComponent.BehaviorState

@export var priority:= 0


var actor: EntityNode

var behavior_component: BehaviorComponent

var target: EntityNode



func _initialize(_actor: EntityNode, _behavior_component: BehaviorComponent) -> void:

	actor = _actor

	behavior_component = _behavior_component






func _start(_target: EntityNode = null) -> void:

	target = _target




func _stop() -> void:

	pass






# Compare a new target to the current one

func _evaluate_new_target(new_target: EntityNode) -> bool:

	return true






func _get_valid_targets() -> Array[EntityNode]:

	var valid_targets: Array[EntityNode] = actor.vision_sensor.entities

	return valid_targets





func _tick(_delta: float) -> void:

	pass