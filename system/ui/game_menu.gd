class_name GameMenu extends Overlay



@export var resume_button: Button

@export var exit_button: Button




func _ready() -> void:

	super()

	resume_button.pressed.connect(_on_resume_pressed)

	exit_button.pressed.connect(_on_exit_pressed)




func _on_resume_pressed() -> void:

	UI.remove_overlay(self)

	hide()




func _on_exit_pressed() -> void:

	UI.remove_overlay(self)

	hide()

	Game.exit()