class_name Behavior extends Resource




@export var behavior_state: BehaviorComponent.BehaviorState

@export var priority:= 0

@export var conditions: Array[Condition]

@export var command_list: Array[Command]

@export var valid_target_defs: Array[EntityDef]



var current_command_index:= 0

var command_data: Dictionary






func _start() -> void:

	_execute_command(0)




func _stop() -> void:

	pass





func _execute_command(index: int) -> void:

	if command_list.size() < index:

		return

	current_command_index = index

	var command = command_list[index]

	command.command_executed.connect(_on_command_executed.bind(command))

	var result = command._execute()




func _on_command_executed(command: Command) -> void:

	pass