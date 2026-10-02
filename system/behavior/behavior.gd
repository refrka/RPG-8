class_name Behavior extends Resource




@export var phases: Array[BehaviorPhase]



var phase_index:= 0



func _initialize(actor: EntityNode) -> void:

	for phase in phases:

		phase._initialize(actor)




func _get_command_data() -> Dictionary:

	return {}