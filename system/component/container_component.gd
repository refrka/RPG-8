class_name ContainerComponent extends InteractableComponent







func _start() -> bool:

	var overlay = UI.show_overlay(ContainerOverlay)

	overlay.overlay_deactivated.connect(_on_overlay_deactivated, CONNECT_ONE_SHOT)

	overlay.load_container_inventory(entity.inventory)

	return false







func _end() -> void:

	var overlay = UI.hide_overlay(ContainerOverlay)

	overlay.clear()






func _on_overlay_deactivated() -> void:

	interaction_overlay_closed.emit()




