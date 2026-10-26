class_name TransitionSensor extends Feature


@export var sensor: Sensor

@export var transition_location_id: StringName

@export var transition_spawn_id: StringName

@export var transition_command_conditions: Array[Condition]

@export var transition_commands: Array[Command]




func _initialize() -> void:

	super()

	sensor._initialize()

	sensor.entity_entered.connect(_on_entity_entered_sensor)





func _activate() -> void:

	if active:

		return

	super()

	sensor._activate()



func _deactivate() -> void:

	if !active:

		return

	super()

	sensor._deactivate()




func _transition() -> void:

	if !transition_commands.is_empty():

		var passed:= true

		for condition in transition_command_conditions:

			if !condition._evaluate():

				passed = false

			if !passed:

				break
		
		if passed:

			for command in transition_commands:

				command._execute()

	_deactivate()

	Scenes.transition_to.call_deferred(transition_location_id, transition_spawn_id)




func _on_entity_entered_sensor(entity: EntityNode) -> void:

	if !active:

		return

	_transition()
