class_name MainMenu extends Control



@export var start_button: Button

@export var quit_button: Button








func _ready() -> void:

	start_button.pressed.connect(_on_start_pressed)

	quit_button.pressed.connect(_on_quit_pressed)





func _on_start_pressed() -> void:

	Game.start()




func _on_quit_pressed() -> void:

	Game.quit()