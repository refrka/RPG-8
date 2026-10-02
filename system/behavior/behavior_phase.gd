class_name BehaviorPhase extends Resource


@export var command_list: Array[Command]



var command_index:= 0

var command_data:= {}




func _initialize(actor: EntityNode) -> void:

	command_data["actor"] = actor




func _start_phase() -> void:

	pass





func _end_phase() -> void:

	pass





func _start_command(index: int) -> void:

	if command_list.size() < index:

		return

	command_index = index

	var command = command_list[index]

	match command._execute(command_data):

		_:

			pass

	command_data = command.data
