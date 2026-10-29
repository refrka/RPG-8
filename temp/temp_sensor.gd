extends Sensor



func _ready() -> void:

	entity_entered.connect(_on_entity_entered_sensor)

	_initialize()

	_activate()





func _on_entity_entered_sensor(_entity: EntityNode) -> void:

	var restrained_state = _entity.state_machine.get_state(BodyRestrainedState)

	restrained_state.restraint_broken.connect(_on_restraint_broken.bind(_entity), CONNECT_ONE_SHOT)

	RestrainCharacterCommand.run.call_deferred({"target": _entity})






func _on_restraint_broken(_entity: EntityNode) -> void:

	_deactivate()

	_entity.state_machine.request_state(BodyIdleState)

	await Game.get_timer(0.5).timeout

	_activate()