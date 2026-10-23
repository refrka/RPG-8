class_name BodyDodgingState extends BodyState



signal dodge_complete


var animation_component: AnimationComponent

var movement_component: MovementComponent




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	animation_component = entity.get_component(AnimationComponent)

	movement_component = entity.get_component(MovementComponent)

	



func _enter() -> void:

	super()

	animation_component.play_body_animation("%s/dodge" % entity.entity_def.entity_id)

	movement_component.set_move_speed_override(400.0)



func _exit() -> void:

	super()

	movement_component.set_move_speed_override(-1.0)



func _connect_signals() -> void:

	animation_component.body_animation_finished.connect(_on_body_animation_finished)




func _disconnect_signals() -> void:

	animation_component.body_animation_finished.disconnect(_on_body_animation_finished)





func _on_body_animation_finished(_anim_name: String) -> void:

	dodge_complete.emit()