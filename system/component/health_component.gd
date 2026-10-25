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





func _clear() -> void:

	max_health = entity.entity_def.base_health

	_set_current_health(max_health, 0.0)




func reduce_health(amount: float) -> void:

	var new_health = max(0, current_health - amount)

	var amount_changed = current_health - new_health

	_set_current_health(new_health, amount_changed)

	if !is_alive():

		_die()

	health_bar.show()




func restore_health(amount: float) -> void:

	var new_health = min(max_health, current_health + amount)

	var amount_changed = new_health - current_health

	_set_current_health(new_health, amount_changed)





func receive_damage_package(damage_package: DamagePackage) -> void:

	for entry in damage_package.damage_entries:

		reduce_health(entry.amount)
		




func is_alive() -> bool:

	return current_health > 0.0



func is_weak() -> bool:

	return current_health / max_health <= 0.3





func _die() -> void:

	var animation_component = entity.get_component(AnimationComponent)

	if animation_component:

		await animation_component.body_animation_finished

	entity._die()




func _set_current_health(new_health: float, amount_changed: float) -> void:

	current_health = new_health

	health_changed.emit(amount_changed, new_health)








func _to_dict() -> Dictionary:

	var dict = {}

	dict["current_health"] = current_health

	dict["max_health"] = max_health

	return dict




func _load_dict(save_dict: Dictionary) -> void:

	current_health = save_dict["current_health"]

	max_health = save_dict["max_health"]