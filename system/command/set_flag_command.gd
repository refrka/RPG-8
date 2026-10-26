class_name SetFlagCommand extends Command



@export var flag: StringName

@export var value: int



func _execute(_data:= {}) -> Result:

	result = super(_data)

	if data.has("flag"):

		flag = data["flag"]

	if data.has("value"):

		value = data["value"]

	flag = flag if !data.has("flag") else data["flag"]

	value = value if !data.has("value") else data["value"]

	Data.set_flag(flag, value)

	return result