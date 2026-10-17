class_name HealthProgressBar extends Overlay



var entity: EntityNode






func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	var health_component = entity.get_component(HealthComponent)

	health_component.health_changed.connect(_on_health_changed)

	self.max_value = health_component.max_health

	self.value = health_component.current_health








func _on_health_changed(_amount: float, new_health: float) -> void:

	self.value = new_health