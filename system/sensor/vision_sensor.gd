class_name VisionSensor extends Sensor









func get_nearest_enemy(enemy_defs: Array[EntityDef]) -> EntityNode:

	var nearest_enemy: EntityNode = null

	var nearest_distance:= INF

	for entity_node in entities:

		if enemy_defs.has(entity_node.entity_def):

			var distance = entity.global_position.distance_squared_to(entity_node.global_position)

			if !nearest_enemy or distance < nearest_distance:

				nearest_enemy = entity_node

				nearest_distance = distance

	return nearest_enemy





