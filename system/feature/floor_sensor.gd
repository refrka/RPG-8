class_name FloorSensor extends Feature


@export var sensor: Sensor

@export var effects_on_enter: Array[Effect]






func _initialize() -> void:

	super()

	sensor._initialize()

	sensor.entity_entered.connect(_on_entity_entered_sensor)




func _trigger(target_entity: EntityNode) -> void:

	for effect in effects_on_enter:

		var effects_component = target_entity.get_component(EffectsComponent)

		if effects_component:

			effects_component.add_effect(effect)





func _activate() -> void:

	super()

	sensor._activate()




func _deactivate() -> void:

	super()

	sensor._deactivate()





func _on_entity_entered_sensor(entity: EntityNode) -> void:

	_trigger(entity)
