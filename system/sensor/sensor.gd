class_name Sensor extends Area2D


signal entity_entered(entity: EntityNode)

signal entity_exited(entity: EntityNode)

signal sensor_entered(sensor: Sensor)

signal sensor_exited(sensor: Sensor)





var active:= false

var entity: EntityNode




var entities: Array[EntityNode]

var sensors: Array[Sensor]




func _initialize(_entity: EntityNode) -> void:

	entity = _entity







func _activate() -> void:

	_connect_signals()

	active = true




func _deactivate() -> void:

	active = false

	_disconnect_signals()




func _connect_signals() -> void:

	area_entered.connect(_on_area_entered_sensor)

	area_exited.connect(_on_area_exited_sensor)

	body_entered.connect(_on_body_entered_sensor)

	body_exited.connect(_on_body_exited_sensor)




func _disconnect_signals() -> void:

	area_entered.disconnect(_on_area_entered_sensor)

	area_exited.disconnect(_on_area_exited_sensor)

	body_entered.disconnect(_on_body_entered_sensor)

	body_exited.disconnect(_on_body_exited_sensor)




func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	if body is EntityNode and body != entity:

		entities.append(body)

		entity_entered.emit(body)




func _on_body_exited_sensor(body: PhysicsBody2D) -> void:

	if body is EntityNode and entities.has(body):

		entities.erase(body)

		entity_exited.emit(body)



func _on_area_entered_sensor(area: Area2D) -> void:

	if area is Sensor and area.entity != entity:

		sensors.append(area)

		sensor_entered.emit(area)



func _on_area_exited_sensor(area: Area2D) -> void:

	if area is Sensor and sensors.has(area):

		sensors.erase(area)

		sensor_exited.emit(area)

