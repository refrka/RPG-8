class_name Hitbox extends Sensor


signal entity_hit(entity_node: EntityNode)


@export var collision_shape: CollisionShape2D


var current_damage_package: DamagePackage

var hit_list: Array[Hurtbox]

var combat_component: CombatComponent






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_component = entity.get_component(CombatComponent)







func can_hit(hurtbox: Hurtbox) -> bool:

	if entity is ProjectileNode and hurtbox.entity == entity.projectile_owner:

		return false

	if hurtbox.entity == entity:

		return false

	var attack_entry = combat_component.get_attack_entry(combat_component.current_attack_index)

	if !attack_entry.hit_self_scene and hurtbox.entity.entity_def == entity.entity_def:

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







func _on_area_entered_sensor(area: Area2D) -> void:

	if area is Hurtbox and can_hit(area):

		hit(area)