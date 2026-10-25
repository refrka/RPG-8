class_name NotificationPanel extends Control



@export var anim_player: AnimationPlayer

@export var content_panel: NotificationContentPanel







func drop() -> void:

	anim_player.play("drop")




func fade() -> void:

	anim_player.play("fade")