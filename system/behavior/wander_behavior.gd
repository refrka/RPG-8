class_name WanderBehavior extends Behavior




@export var wander_distance_range:= Vector2(50.0, 100.0)

@export var idle_duration_range:= Vector2(3.0, 5.0)

@export var wander_speed:= 50.0



var movement_component: MovementComponent

var idle_timer:= 0.0




func _initialize(_actor: EntityNode) -> void:

	super(_actor)

	movement_component = actor.get_component(MovementComponent)






func _connect_signals() -> void:

	movement_component.navigation_position_reached.connect(_on_navigation_position_reached)



func _disconnect_signals() -> void:

	movement_component.navigation_position_reached.disconnect(_on_navigation_position_reached)





func _start(_data:= {}) -> void:

	super(_data)

	movement_component.set_move_speed_override(wander_speed)

	_wander()




func _stop() -> void:

	super()

	movement_component.set_move_speed_override(0.0)




func _wander() -> void:

	var target_position = _get_wander_target_position()

	movement_component.set_navigation_position(target_position)




func _idle() -> void:

	var duration = randf_range(idle_duration_range.x, idle_duration_range.y)

	idle_timer = duration




func _get_wander_target_position() -> Vector2:

	var distance = randf_range(wander_distance_range.x, wander_distance_range.y)

	var dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

	print("wandering distance: ", distance)

	var target_position = actor.global_position + (dir * distance)

	if actor.anchor:

		var anchor_distance = INF

		while anchor_distance > actor.anchor.anchor_range_limit:

			dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

			target_position = actor.global_position + (dir * distance)

			anchor_distance = actor.anchor.global_position.distance_to(target_position)

	return target_position






func _on_navigation_position_reached() -> void:

	_idle()





func _tick(delta: float) -> void:

	if idle_timer > 0.0:

		idle_timer -= delta

		if idle_timer <= 0.0:

			_wander()