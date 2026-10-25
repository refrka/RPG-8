class_name Notification extends Control



@warning_ignore_start("unused_signal")

signal dismissed

signal expired


@export var anim_player: AnimationPlayer

@export var panel: PanelContainer



var timer:= 0.0

var timer_active:= false





func _ready() -> void:

	anim_player.animation_finished.connect(_on_animation_finished)

	panel.mouse_entered.connect(_on_mouse_entered)

	panel.mouse_exited.connect(_on_mouse_exited)

	panel.gui_input.connect(_on_gui_input)



func _start_timer() -> void:

	_reset_timer()

	_activate_timer()




func _reset_timer() -> void:

	timer = 2.5





func _deactivate_timer() -> void:

	timer_active = false




func _activate_timer() -> void:

	timer_active = true




func _expire() -> void:

	expired.emit()






func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == "drop":

		_start_timer()






func _on_mouse_entered() -> void:

	_deactivate_timer()




func _on_mouse_exited() -> void:

	_activate_timer()




func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		print("emitting dismissed")

		dismissed.emit()




func _process(delta: float) -> void:

	if !timer_active:

		return

	timer -= delta

	if timer <= 0.0:

		_expire()




