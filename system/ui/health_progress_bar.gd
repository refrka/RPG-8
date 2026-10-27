class_name HealthProgressBar extends Overlay



var entity: EntityNode

var health_component: HealthComponent






func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	health_component = entity.get_component(HealthComponent)

	health_component.health_changed.connect(_on_health_changed)

	_load_health()










func _load_health() -> void:

	self.max_value = health_component.max_health

	self.value = health_component.current_health







func _on_health_changed(_amount: float, new_health: float) -> void:

	self.value = max(self.max_value / 100.0, new_health)