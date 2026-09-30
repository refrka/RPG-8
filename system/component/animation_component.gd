class_name AnimationComponent extends Component


signal body_animation_finished(anim_name: StringName)

signal combat_animation_finished(anim_name: StringName)

signal sprite_animation_finished


@export var body_anim_player: AnimationPlayer

@export var combat_anim_player: AnimationPlayer



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	if body_anim_player:

		body_anim_player.animation_finished.connect(_on_body_animation_finished)

	if combat_anim_player:

		combat_anim_player.animation_finished.connect(_on_combat_animation_finished)

	entity.animated_body_sprite.animation_finished.connect(_on_sprite_animation_finished)






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

	body_animation_finished.emit(anim_name)



func _on_combat_animation_finished(anim_name: String) -> void:

	combat_animation_finished.emit(anim_name)



func _on_sprite_animation_finished(anim_name: String) -> void:

	sprite_animation_finished.emit(anim_name)