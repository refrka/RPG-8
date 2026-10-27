class_name InteractableComponent extends Component



@warning_ignore_start("unused_signal")

signal interaction_overlay_closed

signal interaction_cancelled

signal interaction_complete





@export var interaction_commands: Array[Command]




func _start() -> bool:

	for command in interaction_commands:

		if command._can_execute():

			command._execute()

	return false




func _end() -> void:

	pass




func _cancel() -> void:

	pass



func _can_interact() -> bool:

	return true