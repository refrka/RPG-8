class_name ProjectileComponent extends Component



var movement_component: MovementComponent

var current_trajectory:= Vector2.ZERO

var expiration_timer_active:= false



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	entity.hitbox.entity_hit.connect(_on_projectile_hit_entity)







func set_trajectory(trajectory: Vector2) -> void:

	var variation = Vector2.ZERO

	if trajectory != Vector2.ZERO:

		variation = Vector2(randf_range(-0.05, 0.05), randf_range(-0.05, 0.05))

	current_trajectory = trajectory + variation

	movement_component.set_move_speed(entity.projectile_def.projectile_speed)





func _start_expiration_timer() -> void:

	expiration_timer_active = true

	var timer = get_tree().create_timer(2.0)

	timer.timeout.connect(_on_expiration_timeout)






func _on_projectile_hit_entity(hit_entity: EntityNode) -> void:

	set_trajectory(Vector2.ZERO)

	movement_component.halt()

	entity.reparent.call_deferred(hit_entity)




func _on_expiration_timeout() -> void:

	entity.queue_free.call_deferred()





func _physics_process(_delta: float) -> void:

	if !active:

		return

	movement_component.set_move_dir(current_trajectory)

	if current_trajectory == Vector2.ZERO and !expiration_timer_active:

		_start_expiration_timer()