class_name ContainerComponent extends InteractableComponent



@export var container_loot_table: LootTable


var opened:= false




func _start() -> bool:

	opened = true

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




