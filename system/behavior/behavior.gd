class_name Behavior extends Resource



@export var display_name: String

@export var required_behavior_state: BehaviorComponent.BehaviorState

@export var priority:= 0


var actor: EntityNode

var behavior_component: BehaviorComponent

var movement_component: MovementComponent

var combat_component: CombatComponent

var target: EntityNode



func _initialize(_actor: EntityNode, _behavior_component: BehaviorComponent) -> void:

	actor = _actor

	behavior_component = _behavior_component

	movement_component = actor.get_component(MovementComponent)
	
	combat_component = actor.get_component(CombatComponent)






func _start(_target: EntityNode = null) -> void:

	_set_target(_target)




func _stop() -> void:

	pass






# Compare a new target to the current one

func _evaluate_new_target(_new_target: EntityNode) -> void:

	return




func _set_target(_target: EntityNode) -> void:

	target = _target






func _get_valid_targets() -> Array[EntityNode]:

	var valid_targets: Array[EntityNode] = actor.vision_sensor.entities

	return valid_targets




func _receive_damage_package(_damage_package: DamagePackage) -> void:

	pass





func _tick(_delta: float) -> void:

	pass