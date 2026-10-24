class_name FloorSensor extends Feature


signal entity_entered(entity_node: EntityNode)


@export var sensor: Sensor


var last_detected_entity: EntityNode



func _initialize() -> void:

	sensor.entity_entered.connect(_on_entity_entered_sensor)





func _on_entity_entered_sensor(entity: EntityNode) -> void:

	last_detected_entity = entity

	entity_entered.emit(entity)
