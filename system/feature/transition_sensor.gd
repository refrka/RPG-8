class_name TransitionSensor extends Feature


@export var sensor: Sensor

@export var transition_location_id: StringName

@export var transition_spawn_id: StringName



func _initialize() -> void:

	super()

	sensor._initialize()

	sensor.entity_entered.connect(_on_entity_entered_sensor)





func _activate() -> void:

	super()

	sensor._activate()



func _deactivate() -> void:

	super()

	sensor._deactivate()




func _on_entity_entered_sensor(entity: EntityNode) -> void:

	print(entity)