class_name NavigationComponent extends Component




var movement_component: MovementComponent


var target_position: Vector2

var target_entity: EntityNode

var follow_buffer:= 16.0




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	entity.nav_agent.navigation_finished.connect(_on_navigation_finished)





func set_target_position(_target_position: Vector2) -> void:

	target_position = _target_position

	entity.nav_agent.target_position = target_position




func stop_navigation() -> void:

	target_position = entity.global_position

	entity.nav_agent.target_position = target_position



func _on_navigation_finished() -> void:

	stop_navigation()




func _physics_process(_delta: float) -> void:

	if !active:

		return

	if !entity.nav_agent.is_navigation_finished():

		var next_position = entity.nav_agent.get_next_path_position()

		var move_dir = entity.global_position.direction_to(next_position)

		movement_component.set_move_dir(move_dir)