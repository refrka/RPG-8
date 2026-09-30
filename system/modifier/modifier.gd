class_name Modifier extends RefCounted



signal expired


enum ValueType {

	VECTOR_2,

	FLOAT,

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

	return false





func _tick(delta: float) -> void:

	_time_alive += delta

	if _is_expired():

		expired.emit()





static func new_modifier(value: Variant, _duration:= -1.0) -> Modifier:

	var modifier = Modifier.new()

	modifier.set_value(value)

	modifier.duration = _duration

	return modifier



static func new_decay(value: Variant, _decay: float) -> Modifier:

	return null