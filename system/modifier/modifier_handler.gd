class_name ModifierHandler extends Node



var modifiers: Array[Modifier]






func add_modifier(modifier: Modifier) -> void:

	modifiers.append(modifier)

	modifier.expired.connect(_on_modifier_expired.bind(modifier))




func remove_modifier(modifier: Modifier) -> void:

	if modifiers.has(modifier):

		modifiers.erase(modifier)
	



func get_vector_total() -> Vector2:

	var total:= Vector2.ZERO

	for modifier in modifiers:

		if modifier.type == Modifier.ValueType.VECTOR_2:

			total += modifier.vector_value

	return total




func get_float_total() -> float:

	var total:= 0.0

	for modifier in modifiers:

		if modifier.type == Modifier.ValueType.FLOAT:

			total += modifier.float_value

	return total








func _on_modifier_expired(modifier: Modifier) -> void:

	remove_modifier(modifier)




func _process(delta: float) -> void:

	for modifier in modifiers:

		modifier._tick(delta)
