class_name Command extends Resource

@warning_ignore("unused_signal")

signal command_executed


enum Result {

	SUCCESS,

	FAILURE,

	PENDING,

	CANCELLED,

}




var data:= {}

var actor: EntityNode

var result: Result





func _execute(_data:= {}) -> Result:

	data = _data

	actor = data["actor"]

	return Result.SUCCESS





static func run(_data:= {}) -> Result:

	return Result.SUCCESS



