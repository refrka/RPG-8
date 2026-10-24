class_name Player extends CharacterNode


@export var interaction_area: InteractionArea

var current_spawn_id: StringName



func _initialize() -> bool:

	if !super():

		return false

	interaction_area._initialize(self)

	Events.fire(PlayerInitializedEvent)

	return true






func _activate() -> void:

	super()

	interaction_area.monitoring = true



func _deactivate() -> void:

	super()

	interaction_area.monitoring = false


	


func _die() -> void:

	super()

	Game.exit()