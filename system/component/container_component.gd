class_name ContainerComponent extends InteractableComponent



@export var container_loot_table: LootTable


var opened:= false




func _start() -> bool:

	opened = true

	if container_loot_table:

		var loot = container_loot_table.get_loot(randf())

		for item_def in loot:

			var count = loot[item_def]

			entity.inventory.add_item(item_def, count)

	var overlay = UI.show_overlay(ContainerOverlay)

	overlay.overlay_deactivated.connect(_on_overlay_deactivated, CONNECT_ONE_SHOT)

	overlay.load_container_inventory(entity.inventory)

	return false







func _end() -> void:

	var overlay = UI.hide_overlay(ContainerOverlay)

	overlay.clear()






func _on_overlay_deactivated() -> void:

	interaction_overlay_closed.emit()






func to_dict() -> Dictionary:

	var save_dict:= {}

	if container_loot_table:

		save_dict["loot_table"] = container_loot_table.to_dict()

	return save_dict




func load_dict(save_dict: Dictionary) -> void:

	if save_dict.has("loot_table"):

		container_loot_table.load_dict(save_dict["loot_table"])