class_name CombatChargingState extends CombatState


signal charge_complete








func _enter() -> void:

	super()
	
	animation_component.play_combat_animation(combat_component.current_animation_name)



func _exit() -> void:

	super()

	animation_component.combat_anim_player.play("RESET")




func _disconnect_signals() -> void:

	animation_component.combat_animation_finished.disconnect(_on_combat_animation_finished)




func _connect_signals() -> void:

	if !animation_component.combat_animation_finished.is_connected(_on_combat_animation_finished):

		animation_component.combat_animation_finished.connect(_on_combat_animation_finished)

	


func _on_combat_animation_finished(anim_name: StringName) -> void:

	if anim_name == combat_component.current_animation_name:

		charge_complete.emit()