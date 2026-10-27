class_name SaveComponent extends InteractableComponent



@export var spawn_id: StringName




func _start() -> bool:

	super()

	var player = Game.get_player()

	player.current_spawn_id = spawn_id

	Game.save()

	return true