class_name BodyDodgingState extends BodyState



signal dodge_complete


var animation_component: AnimationComponent

var movement_component: MovementComponent

var dodge_modifier: Modifier



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	animation_component = entity.get_component(AnimationComponent)

	movement_component = entity.get_component(MovementComponent)

	



func _enter() -> void:

	super()

	animation_component.play_body_animation("%s/dodge" % entity.entity_def.entity_id)

	entity.hurtbox.monitorable = false

	movement_component.set_move_speed_override(0.0)

	if !dodge_modifier:

		dodge_modifier = Modifier.new_decay_vector(movement_component.face_dir * 200.0, 10.0, 0.4) 

		movement_component.modifier_handler.add_modifier(dodge_modifier)



func _exit() -> void:

	super()

	animation_component.body_anim_player.play("RESET")

	entity.hurtbox.set.call_deferred("monitorable", true)

	movement_component.set_move_speed_override(-1.0)

	movement_component.modifier_handler.remove_modifier(dodge_modifier)

	dodge_modifier = null



func _connect_signals() -> void:

	animation_component.body_animation_finished.connect(_on_body_animation_finished)




func _disconnect_signals() -> void:

	animation_component.body_animation_finished.disconnect(_on_body_animation_finished)





func _on_body_animation_finished(_anim_name: String) -> void:

	dodge_complete.emit()