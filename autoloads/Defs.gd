extends Node







var entity_defs: Dictionary[StringName, EntityDef]

var item_defs: Dictionary[StringName, ItemDef]




func _ready() -> void:

	_load_defs()




func get_item_def(item_id: StringName) -> ItemDef:

	if item_defs.has(item_id):

		return item_defs[item_id]

	return null




func get_entity_def(entity_id: StringName) -> EntityDef:

	if entity_defs.has(entity_id):

		return entity_defs[entity_id]

	return null




func _load_defs() -> void:

	var paths = ["res://entities/"]

	while !paths.is_empty():

		var current_path = paths.pop_back()

		for dir in ResourceLoader.list_directory(current_path):

			if dir.ends_with("/"):

				paths.append(current_path + dir)

			elif dir.ends_with(".tres"):

				var def = load(current_path + dir) as EntityDef

				entity_defs[def.entity_id] = def

	paths.append("res://items/")

	while !paths.is_empty():

		var current_path = paths.pop_back()

		for dir in ResourceLoader.list_directory(current_path):

			if dir.ends_with("/"):

				paths.append(current_path + dir)

			elif dir.ends_with(".tres"):

				var def = load(current_path + dir) as ItemDef

				item_defs[def.item_id] = def