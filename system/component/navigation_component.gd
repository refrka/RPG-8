class_name NavigationComponent extends Component



signal navigation_finished



var movement_component: MovementComponent


var target_position: Vector2

var target_entity: EntityNode

var follow_buffer:= 16.0




func _initialize(_entity: EntityNode) -> void:

	if disabled:

		return

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	entity.nav_agent.navigation_finished.connect(_on_navigation_finished)

	entity.nav_agent.velocity_computed.connect(_on_velocity_computed)





func set_target_position(_target_position: Vector2) -> void:

	target_position = _target_position

	

	entity.nav_agent.target_position = target_position





func set_forced_velocity(velocity: Vector2) -> void:

	entity.nav_agent.set_velocity(velocity)






func stop_navigation() -> void:

	target_position = entity.global_position

	entity.nav_agent.target_position = target_position




func _on_navigation_finished() -> void:

	stop_navigation()

	navigation_finished.emit()




func _on_velocity_computed(velocity: Vector2) -> void:

	movement_component.set_move_dir(velocity)




func _physics_process(_delta: float) -> void:

	if !active:

		return

	var position = entity.nav_agent.get_next_path_position()

	var dir_velocity = entity.global_position.direction_to(position)

	if entity.nav_agent.avoidance_enabled:

		entity.nav_agent.set_velocity(dir_velocity)

	else:

		_on_velocity_computed(dir_velocity)
