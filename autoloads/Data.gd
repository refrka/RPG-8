extends Node


signal flag_updated(flag: StringName, new_value: int)


var flags: Dictionary[StringName, int]



func _ready() -> void:

	var config_flags = load("res://resources/config/flags_config.tres").flags as Dictionary[StringName, int]

	flags.assign(config_flags)




func get_flag(flag: StringName) -> int:

	if flags.has(flag):

		return flags[flag]

	return -1




func set_flag(flag: StringName, value: int) -> void:

	flags[flag] = value

	flag_updated.emit(flag, value)