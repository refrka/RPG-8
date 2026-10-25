class_name MeleeAttackBehavior extends Behavior





func _initialize(_actor: EntityNode, _behavior_component: BehaviorComponent) -> void:

	super(_actor, _behavior_component)

	actor.combat_melee_sensor.entity_entered.connect(_on_entity_entered_combat_melee_sensor)

	movement_component.navigation_position_reached.connect(_on_navigation_position_reached)





func _start(_target: EntityNode = null) -> void:

	super(_target)

	movement_component.set_navigation_target(target)






func _on_entity_entered_combat_melee_sensor(entity: EntityNode) -> void:

	if entity == target:

		combat_component._try_attack()




func _on_navigation_position_reached() -> void:

	combat_component._try_attack()