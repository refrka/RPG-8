class_name RestoreHealthInstantEffect extends InstantEffect




@export var amount: float




func _apply() -> void:

	var health_component = entity.get_component(HealthComponent)

	if health_component:

		health_component.restore_health(amount)