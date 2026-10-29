class_name AnimationComponent extends Component


signal body_animation_finished(anim_name: StringName)

signal combat_animation_finished(anim_name: StringName)


@export var body_anim_player: AnimationPlayer

@export var combat_anim_player: AnimationPlayer


var movement_component: MovementComponent




func _initialize(_entity: EntityNode) -> void:

	if disabled:

		return

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_updated.connect(_on_face_dir_updated)

	if body_anim_player:

		body_anim_player.animation_finished.connect(_on_body_animation_finished)

	if combat_anim_player:

		combat_anim_player.animation_finished.connect(_on_combat_animation_finished)

	if body_anim_player.current_animation == "%s/idle" % entity.entity_def.entity_id:

		var animation_length = body_anim_player.current_animation_length

		var random_position = randf_range(0.0, animation_length)

		body_anim_player.seek(random_position)






func play_body_animation(anim_name: String) -> void:

	if body_anim_player:

		body_anim_player.play(anim_name)



func play_combat_animation(anim_name: String) -> void:

	if combat_anim_player:

		combat_anim_player.play(anim_name)



func play_sprite_animation(anim_name: String) -> void:

	entity.animated_body_sprite.play(anim_name)




func receive_damage_package(_damage_package: DamagePackage) -> void:	

	play_body_animation("flash")






func get_combat_animation_node() -> CombatAnimationNode:

	return load("res://system/combat/combat_animation_node.tscn").instantiate()





func _on_body_animation_finished(anim_name: String) -> void:

	if anim_name == "flash":

		body_anim_player.play("%s/idle" % entity.entity_def.entity_id)

	body_animation_finished.emit(anim_name)



func _on_combat_animation_finished(anim_name: String) -> void:

	combat_animation_finished.emit(anim_name)



func _on_face_dir_updated() -> void:

	if movement_component.face_dir.x < 0:

		entity.body_sprite.flip_h = true

		entity.hurtbox.scale.x = -1

	else:

		entity.body_sprite.flip_h = false

		entity.hurtbox.scale.x = 1

