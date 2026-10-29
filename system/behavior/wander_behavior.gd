class_name WanderBehavior extends Behavior



@export var idle_duration_range:= Vector2(2.0, 3.0)

@export var wander_distance_range:= Vector2(50.0, 150.0)

@export var wander_speed_override:= 50.0



var idle_timer:= 0.0









func _start(_target: EntityNode = null) -> void:

	super(_target)

	movement_component.navigation_position_reached.connect(_on_wander_position_reached)

	if wander_speed_override != -1.0:

		movement_component.set_move_speed_override(wander_speed_override)

	_idle()




func _stop() -> void:

	movement_component.navigation_position_reached.disconnect(_on_wander_position_reached)

	movement_component.set_move_speed_override(-1.0)






func _idle() -> void:

	var duration = randf_range(idle_duration_range.x, idle_duration_range.y)

	idle_timer = duration




func _wander() -> void:

	var dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

	var distance = randf_range(wander_distance_range.x, wander_distance_range.y)

	movement_component.set_navigation_position(actor.global_position + (dir * distance))





func _on_wander_position_reached() -> void:

	_idle()








func _tick(delta: float) -> void:

	if idle_timer > 0.0:

		idle_timer -= delta

		if idle_timer <= 0.0:

			_wander()