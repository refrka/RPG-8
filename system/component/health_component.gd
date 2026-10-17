class_name HealthComponent extends Component


signal health_changed(amount: float, new_value: float)



var current_health:= 1.0

var max_health:= 1.0

var health_bar: HealthProgressBar




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	max_health = entity.entity_def.base_health

	current_health = max_health

	health_bar = entity.health_bar

	if health_bar:
	
		health_bar._initialize(entity)






func reduce_health(amount: float) -> void:

	var new_health = max(0, current_health - amount)

	_set_current_health(new_health)

	if !is_alive():

		_die()

	health_changed.emit(amount, new_health)

	health_bar.show()




func restore_health(amount: float) -> void:

	var new_health = min(max_health, current_health + amount)

	_set_current_health(new_health)

	health_changed.emit(amount, new_health)





func receive_damage_package(damage_package: DamagePackage) -> void:

	for entry in damage_package.damage_entries:

		reduce_health(entry.amount)
		




func is_alive() -> bool:

	return current_health > 0.0





func _die() -> void:

	var animation_component = entity.get_component(AnimationComponent)

	if animation_component:

		await animation_component.body_animation_finished

	entity._die()

	entity.queue_free.call_deferred()




func _set_current_health(new_health: float) -> void:

	current_health = new_health




