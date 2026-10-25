class_name InteractableComponent extends Component



@warning_ignore_start("unused_signal")

signal interaction_overlay_closed

signal interaction_cancelled

signal interaction_complete




func _start() -> bool:

	return false




func _end() -> void:

	pass




func _cancel() -> void:

	pass



func _can_interact() -> bool:

	return true