class_name MoveToPositionCommand extends Command


var target_position: Vector2


func _execute(_data:= {}) -> Result:

	super(_data)

	target_position = data["target_position"]

	var navigation_component = actor.get_component(NavigationComponent)

	if !navigation_component:

		result = Result.FAILURE

	else:

		navigation_component.set_target_position(target_position)

		navigation_component.navigation_finished.connect(_on_navigation_finished)

		result = Result.PENDING

	return result




func _on_navigation_finished() -> void:

	result = Result.SUCCESS

	command_executed.emit()






static func run(_data:= {}) -> Result:

	var command = MoveToPositionCommand.new()

	command._execute(_data)

	return command.result