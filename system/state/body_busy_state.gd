class_name BodyBusyState extends BodyState





var movement_component: MovementComponent





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)




func _enter() -> void:

	super()

	movement_component.set_move_speed_override(0.0)




func _exit() -> void:

	super()

	movement_component.set_move_speed_override(-1.0)
