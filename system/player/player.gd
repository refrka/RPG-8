class_name Player extends CharacterNode








func _initialize() -> bool:

	if !super():

		return false

	PlayerInitializedEvent.fire()

	return true