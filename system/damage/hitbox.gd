class_name Hitbox extends Area2D



var active:= false

var entity: EntityNode



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

	if hit_list.has(hurtbox):

		return false

	return not hurtbox.invulnerable




func hit(hurtbox: Hurtbox) -> void:

	hit_list.append(hurtbox)







func _on_area_entered(area: Area2D) -> void:

	if area is Hurtbox and can_hit(area):

		hit(area)