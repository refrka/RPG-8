class_name HealthComponent extends Component





var current_health:= 1.0

var max_health:= 1.0






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	max_health = entity.entity_def.base_health

	current_health = max_health






func reduce_health(amount: float) -> void:

	var new_health = max(0, current_health - amount)

	_set_current_health(new_health)

	if !is_alive():

		_die()




func restore_health(amount: float) -> void:

	var new_health = min(max_health, current_health + amount)

	_set_current_health(new_health)





func receive_damage_package(damage_package: DamagePackage) -> void:

	for entry in damage_package.damage_entries:

		reduce_health(entry.amount)
		




func is_alive() -> bool:

	return current_health > 0.0





func _die() -> void:

	var animation_component = entity.get_component(AnimationComponent)

	if animation_component:

		await animation_component.body_animation_finished

	var item_def = load("res://items/consumable/food/apple_def.tres")

	var node = ItemNode.create_new(item_def)
	
	Scenes.current_location.add_entity_node(node, entity.global_position)

	entity.queue_free.call_deferred()




func _set_current_health(new_health: float) -> void:

	current_health = new_health




