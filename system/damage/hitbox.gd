class_name Hitbox extends Area2D


signal entity_hit(entity_node: EntityNode)


@export var collision_shape: CollisionShape2D


var active:= false

var entity: EntityNode

var current_damage_package: DamagePackage


var hit_list: Array[Hurtbox]






func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	






func _activate() -> void:
	
	active = true

	_connect_signals()






func _deactivate() -> void:

	_disconnect_signals()

	active = false





func _connect_signals() -> void:

	area_entered.connect(_on_area_entered)





func _disconnect_signals() -> void:

	area_entered.disconnect(_on_area_entered)





func can_hit(hurtbox: Hurtbox) -> bool:

	if entity is ProjectileNode and hurtbox.entity == entity.projectile_owner:

		return false

	if hurtbox.entity == entity:

		return false

	if hit_list.has(hurtbox):

		return false

	return not hurtbox.invulnerable




func hit(hurtbox: Hurtbox) -> void:

	hit_list.append(hurtbox)

	var hit_entity = hurtbox.entity

	hit_entity.receive_damage_package(current_damage_package)

	entity_hit.emit(hit_entity)

	




func clear_hit_list() -> void:

	hit_list.clear()







func _on_area_entered(area: Area2D) -> void:

	if area is Hurtbox and can_hit(area):

		hit(area)