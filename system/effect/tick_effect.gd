class_name TickEffect extends Effect


signal ticked



@export var tick_rate:= 1.0

@export var last_tick: float




func _tick(_delta: float) -> void:

	super(_delta)

	if _time_alive - last_tick >= tick_rate:
		
		last_tick = _time_alive

		ticked.emit()