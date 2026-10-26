class_name NoticePanel extends MarginContainer



signal expired

signal dismissed


@export var panel: PanelContainer

@export var anim_player: AnimationPlayer

@export var duration:= 1.5


var notice: Notice



var active:= false

var timer_active:= false

var timer:= 0.0





func _ready() -> void:

	anim_player.animation_finished.connect(_on_animation_finished)

	panel.mouse_entered.connect(_on_mouse_entered)

	panel.mouse_exited.connect(_on_mouse_exited)

	panel.gui_input.connect(_on_gui_input)





func _load_notice(_notice: Notice) -> void:

	notice = _notice






func _activate() -> void:

	active = true

	anim_player.play("drop")




func _deactivate() -> void:

	active = false




func _fade() -> void:

	timer_active = false

	anim_player.play("fade")




func _expire() -> void:

	expired.emit()




func _start_timer() -> void:

	_reset_timer()

	timer_active = true



func _stop_timer() -> void:

	timer_active = false



func _reset_timer() -> void:

	timer = duration




func _on_animation_finished(anim_name: String) -> void:

	if anim_name == "drop":

		_start_timer()

	elif anim_name == "fade":

		_expire()



func _on_mouse_entered() -> void:

	_stop_timer()



func _on_mouse_exited() -> void:

	_reset_timer()

	_start_timer()



func _on_gui_input(event: InputEvent) -> void:

	if active and event is InputEventMouseButton and event.is_pressed():

		_stop_timer()

		_fade()




func _process(delta: float) -> void:

	if !active or !timer_active:

		return

	timer -= delta

	if timer <= 0.0:

		_fade()
