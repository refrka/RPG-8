class_name Player extends CharacterNode


@export var interaction_area: InteractionArea



func _initialize() -> bool:

	if !super():

		return false

	interaction_area._initialize(self)

	PlayerInitializedEvent.fire()

	return true






func _activate() -> void:

	super()

	interaction_area.monitoring = true



func _deactivate() -> void:

	super()

	interaction_area.monitoring = false

	