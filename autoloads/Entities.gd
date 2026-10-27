extends Node




func get_entity_node(entity_id: StringName) -> EntityNode:

	var entity_def = Defs.get_entity_def(entity_id)

	var entity_node = load(entity_def.scene_path).instantiate()

	return entity_node