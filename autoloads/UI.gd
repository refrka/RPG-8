extends Node




var overlay_registry: Dictionary[Script, Overlay] = {}

var active_overlays: Array[Overlay]






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS



func register_overlay(overlay: Overlay) -> void:

	overlay_registry[overlay.get_script()] = overlay

	overlay.hide()





func add_overlay(overlay: Overlay) -> void:

	active_overlays.append(overlay)

	if overlay.pause and !Game.is_paused():

		Game.pause()



func remove_overlay(overlay: Overlay) -> void:

	active_overlays.erase(overlay)

	for active_overlay in active_overlays:

		if active_overlay.pause:

			return

	if overlay.pause and Game.is_paused():

		Game.unpause()







func get_overlay(overlay_script: Script) -> Overlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if Game.active:

			if !active_overlays.is_empty():

				var overlay = active_overlays.back()

				remove_overlay(overlay)

				overlay.hide()

			else:

				var overlay = get_overlay(GameMenu)

				add_overlay(overlay)

				overlay.show()

	if event.is_action_pressed("profile"):

		if Game.active:

			var overlay = get_overlay(ProfileOverlay)
