class_name Overlay extends Control


signal overlay_deactivated


@export var pause:= false

var active:= false



func _ready() -> void:

	UI.register_overlay(self)





func _activate() -> void:

	active = true




func _deactivate() -> void:

	active = false

	overlay_deactivated.emit()