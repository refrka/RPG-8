class_name NavigationComponent2 extends Component



var target_position: Vector2


var idle:= false

var idle_timer:= 0.0





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	entity.nav_agent.navigation_finished.connect(_on_navigation_finished)

	entity.nav_agent.velocity_computed.connect(_on_velocity_computed)

	entity.nav_agent.link_reached.connect(_on_link_reached)






func _activate() -> void:

	super()

	var position = get_random_target_position()

	set_target_position(position)







func set_target_position(position: Vector2) -> void:

	target_position = position

	entity.nav_agent.target_position = position





func get_random_target_position() -> Vector2:

	return entity.global_position + Vector2(randf_range(-400.0, 400.0), randf_range(-400.0, 400.0))







func _on_navigation_finished() -> void:

	idle = true

	idle_timer = 3.0




func _on_velocity_computed(velocity: Vector2) -> void:

	entity.velocity = velocity



func _on_link_reached(details: Dictionary) -> void:

	pass




func _physics_process(delta: float) -> void:

	if !active:

		return

	if idle:

		idle_timer -= delta

		if idle_timer <= 0.0:

			idle = false

			set_target_position(get_random_target_position())

	if entity.nav_agent.is_navigation_finished():

		return

	var position = entity.nav_agent.get_next_path_position()

	var velocity = entity.global_position.direction_to(position) * 150.0

	if entity.nav_agent.avoidance_enabled:

		entity.nav_agent.set_velocity(velocity)

	else:

		_on_velocity_computed(velocity)

	entity.move_and_slide()
