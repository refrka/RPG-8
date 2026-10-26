class_name IsFlagValueCondition extends Condition


@export var flag: StringName

@export var value: int




func _evaluate(_data:= {}) -> bool:

	super(_data)

	if data.has("flag"):

		flag = data["flag"]

	if data.has("value"):

		value = data.has("value")

	return Data.get_flag(flag) == value