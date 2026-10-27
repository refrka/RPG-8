class_name CombatAttackingState extends CombatState


signal attack_complete






func _enter() -> void:

	super()

	var attack_entry = combat_component.get_attack_entry(combat_component.current_attack_index)

	movement_component.set_move_speed_override(attack_entry.speed_modifier)
	
	animation_component.play_combat_animation(combat_component.current_animation_name)




func _exit() -> void:

	super()

	animation_component.combat_anim_player.play("RESET")

	movement_component.set_move_speed_override(-1.0)




func _disconnect_signals() -> void:

	animation_component.combat_animation_finished.disconnect(_on_combat_animation_finished)




func _connect_signals() -> void:

	if !animation_component.combat_animation_finished.is_connected(_on_combat_animation_finished):

		animation_component.combat_animation_finished.connect(_on_combat_animation_finished)

	


func _on_combat_animation_finished(anim_name: StringName) -> void:

	if anim_name == combat_component.current_animation_name:

		attack_complete.emit()