class_name Modifier extends RefCounted



signal expired


enum ValueType {

	VECTOR_2,

	FLOAT,

	MULTIPLIER,

}



var type: ValueType

var float_value:= -1.0

var vector_value:= Vector2.ZERO

var duration:= -1.0

var decay:= 50.0

var _time_alive:= 0.0









func set_value(value: Variant) -> void:

	if value is Vector2:

		vector_value = value

		type = ValueType.VECTOR_2

	elif value is float:

		float_value = value

		type = ValueType.FLOAT




func _is_expired() -> bool:

	if duration != -1.0:

		return _time_alive >= duration

	elif decay > 0.0:

		if float_value != -1.0:

			return float_value == 0.0

		else:

			return vector_value.length() <= 0.001

	return false





func _tick(delta: float) -> void:

	_time_alive += delta

	if decay > 0.0:

		if duration != -1.0 and _time_alive >= duration:

			float_value *= clampf(1.0 - decay * delta, 0.0, 1.0)

			vector_value *= clampf(1.0 - decay * delta, 0.0, 1.0)

	if _is_expired():

		expired.emit()





static func new_modifier(value: Variant, _duration:= -1.0) -> Modifier:

	var modifier = Modifier.new()

	modifier.set_value(value)

	modifier.duration = _duration

	return modifier



static func new_multiplier(value: Variant, _duration:= -1.0) -> Modifier:

	var modifier = Modifier.new()

	modifier.set_value(value)

	modifier.duration = _duration

	modifier.type = Modifier.ValueType.MULTIPLIER

	return modifier




static func new_decay_vector(value: Vector2, _decay: float, _duration:= -1.0) -> Modifier:

	var modifier = Modifier.new()

	modifier.set_value(value)

	modifier.duration = _duration

	modifier.decay = _decay

	modifier.type = Modifier.ValueType.VECTOR_2

	return modifier