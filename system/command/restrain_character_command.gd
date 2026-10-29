class_name RestrainCharacterCommand extends Command



var target: CharacterNode



func _execute(_data:= {}) -> Result:

	result = super(_data)

	if !data.has("target"):

		result = Result.FAILURE

		return result

	target = data["target"]

	if not target is CharacterNode:

		result = Result.FAILURE

		return result

	target.state_machine.request_state(BodyRestrainedState)

	return result




static func run(_data:= {}) -> Result:

	var command = RestrainCharacterCommand.new()

	return command._execute(_data)