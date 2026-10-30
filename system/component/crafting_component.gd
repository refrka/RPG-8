class_name CraftingComponent extends InteractableComponent





func _start() -> bool:

	var crafting_overlay = UI.show_overlay(CraftingOverlay)

	crafting_overlay.overlay_deactivated.connect(_on_overlay_deactivated, CONNECT_ONE_SHOT)

	crafting_overlay.load_crafting_source(entity)

	return false





func _end() -> void:

	var crafting_overlay = UI.hide_overlay(CraftingOverlay)

	crafting_overlay.clear()










func _on_overlay_deactivated() -> void:

	interaction_overlay_closed.emit()
