class_name MeleeAttackBehavior extends Behavior





func _initialize(_actor: EntityNode, _behavior_component: BehaviorComponent) -> void:

	super(_actor, _behavior_component)

	actor.combat_melee_sensor.sensor_entered.connect(_on_sensor_entered_combat_melee_sensor)

	movement_component.navigation_position_reached.connect(_on_navigation_position_reached)







func _set_target(_target: EntityNode) -> void:

	super(_target)

	movement_component.set_navigation_target(target)







func _evaluate_new_target(new_target: EntityNode) -> void:

	if !is_instance_valid(new_target):

		return

	if !is_instance_valid(target):

		_set_target(new_target)





func _receive_damage_package(damage_package: DamagePackage) -> void:

	print("receiving damage to ", actor)

	if is_instance_valid(damage_package.source_entity_node) and damage_package.source_entity_node != target:

		_set_target(damage_package.source_entity_node)

		print("setting target")
		




func _on_sensor_entered_combat_melee_sensor(sensor: Sensor) -> void:

	if sensor is Hurtbox and sensor.entity == target and !combat_component.is_attacking():

		combat_component._try_attack()




func _on_navigation_position_reached() -> void:

	combat_component._try_attack()