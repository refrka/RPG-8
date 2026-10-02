extends Node




var overlay_registry: Dictionary[Script, Overlay] = {}

var active_overlays: Array[Overlay]

var mouse_item_slot: MouseItemSlot




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	mouse_item_slot = get_tree().get_first_node_in_group("mouse_item_slot")





func register_overlay(overlay: Overlay) -> void:

	overlay_registry[overlay.get_script()] = overlay

	overlay.hide()





func add_overlay(overlay: Overlay) -> void:

	active_overlays.append(overlay)

	if overlay.pause and !Game.is_paused():

		Game.pause()

	overlay._activate()



func remove_overlay(overlay: Overlay) -> void:

	overlay._deactivate()

	active_overlays.erase(overlay)

	for active_overlay in active_overlays:

		if active_overlay.pause:

			return

	if overlay.pause and Game.is_paused():

		Game.unpause()



func show_overlay(overlay_script: Script) -> Overlay:

	var overlay = get_overlay(overlay_script)

	add_overlay(overlay)

	overlay.show()

	return overlay



func hide_overlay(overlay_script: Script) -> Overlay:

	var overlay = get_overlay(overlay_script)

	if !overlay.active:

		return overlay

	remove_overlay(overlay)

	overlay.hide()

	return overlay





func get_overlay(overlay_script: Script) -> Overlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null




func is_overlay_active(overlay_script: Script) -> bool:

	var overlay = get_overlay(overlay_script)

	return active_overlays.has(overlay)




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if Game.active:

			if !active_overlays.is_empty():

				var overlay = active_overlays.back()

				remove_overlay(overlay)

				overlay.hide()

			else:

				show_overlay(GameMenu)

	if event.is_action_pressed("profile"):

		if Game.active:

			if is_overlay_active(ProfileOverlay):

				hide_overlay(ProfileOverlay)
				
			else:

				show_overlay(ProfileOverlay)