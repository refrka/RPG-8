class_name HarvestComponent extends TimedInteractableComponent



@export var harvest_loot_table: LootTable

@export var ready_texture_frame:= 1

@export var harvested_texture_frame:= 0


var harvested:= false






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	entity.body_sprite.frame = ready_texture_frame





func _can_interact() -> bool:

	return not harvested





func _complete() -> void:

	var roll = randf()

	var loot = harvest_loot_table.get_loot(roll)

	for item_def in loot:

		var count = loot[item_def]

		var target_position = entity.global_position + Vector2(randf_range(-30.0, 30.0), randf_range(1.0, 30.0))

		Scenes.current_location.drop_item(item_def, target_position, count)

	harvested = true

	entity.body_sprite.frame = harvested_texture_frame

	interaction_complete.emit()



